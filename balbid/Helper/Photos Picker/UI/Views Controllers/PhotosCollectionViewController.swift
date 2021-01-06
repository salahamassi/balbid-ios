//
//  PhotosCollectionViewController.swift
//  MSA
//
//  Created by Salah Amassi on 2/13/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var allPhotos = [PhotoWrapper]()
    private var assets = [PHAsset]()

    private var selectedUrls = [URL]()
    private var selectedImages = [UIImage]()
    private let emptyView = EmptyView.initFromNib()

    private var data = [AlbumModel]()

    var selectedPhotos = [PhotoWrapper]() {
        didSet {
            if selectedPhotos.isEmpty {
                titleLabel.text = "\(album?.name ?? "keyword.recents".localized)"
            } else {
                titleLabel.text = "\(album?.name ?? "keyword.recents".localized)"
            }
        }
    }

    var inDownloadingProgressPhotos = [PhotoWrapper]()

    private lazy var doneBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(performDoneBarButtonAction))
        return barButtonItem
    }()

    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(performCancelBarButtonAction))
        return barButtonItem
    }()

    private lazy var albumButton: UIButton = {
        let button = UIButton()
        button.setTitle("button.normalTitle.albums".localized, for: .normal)
        button.setTitleColor(UIColor.appColor(.labelColor) ?? .black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(performAlbumButtonAction), for: .primaryActionTriggered)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appColor(.labelColor)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performAlbumButtonAction)))
        return label
    }()

    private var page = 10
    private var beginIndex = 0
    private var endIndex = 9
    private var loading = false
    private var hasNextPage = false
    private var cameraOffset: Int = 0

    private let activityIndicator = UIActivityIndicatorView()
    private var allPhotosAssetResults: PHFetchResult<PHAsset>?

    weak var delegate: PhotosCollectionViewControllerDelegate?
    var album: AlbumModel?

    private let photoCellId = "photoCellId"
    var maxSelection: Int?

    private var imagePickerHelper: ImagePickerHelper?
    var cameraMode = false
    private var imageRequestsIDs = [PHImageRequestID]()

    @available(iOS 12.0, *)
    var isDarkMode: Bool {
        UserDefaultsManager.isDarkMode || traitCollection.userInterfaceStyle == .dark
    }

    deinit {
        for imageRequestID in imageRequestsIDs {
            PHImageManager.default().cancelImageRequest(imageRequestID)
        }
    }

    init(delegate: PhotosCollectionViewControllerDelegate? = nil) {
        self.delegate = delegate
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("Fuck storyboard!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.setupPhotoAsset()
            self?.setupAlbums()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            if self.cameraMode {
                self.cameraMode = false
                return
            }
            self.checkThePreviousSelectedPhotos()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }

    }

    // MARK: Setup functions
    fileprivate func setupViewController() {
        titleLabel.text = "label.text.photosPickerTitle".localized
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            navigationController?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        navigationItem.rightBarButtonItem = doneBarButtonItem
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        clearsSelectionOnViewWillAppear = false
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: photoCellId)
        collectionView.backgroundColor = .clear
        view.backgroundColor = UIColor.appColor(.viewBackgroundColor)

        view.addSubview(activityIndicator)
        view.addSubview(albumButton)

        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, albumButton])
        titleStackView.axis = .vertical
        titleStackView.spacing = 1
        titleStackView.alignment = .center
        titleStackView.distribution = .equalCentering

        navigationItem.titleView = titleStackView

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        imagePickerHelper = ImagePickerHelper(viewController: self, router: router)
        imagePickerHelper?.imageCompletion = .some({ [weak self] (image) in
            guard let self = self else { return }
            self.allPhotos.insert(PhotoWrapper(image: image, isDownloading: false, progress: 0, isSelected: true, mustDownloadImage: false), at: 1)
            self.assets.insert(.init(), at: 1)
            self.cameraOffset = self.cameraOffset + 1
            let indexPath = IndexPath(item: 1, section: 0)
            if let maxSelection = self.maxSelection {
                if self.selectedPhotos.count + self.inDownloadingProgressPhotos.count >= maxSelection {
                    self.deselectPhoto(with: .init(item: self.selectedPhotos.count  - 1, section: 0))
                }
            }
            self.selectedPhotos.append(self.allPhotos[indexPath.item])
            guard let fileURL = self.allPhotos[indexPath.item].image.jpeg(.medium)?.saveImage() else { return }
            self.selectedUrls.append(fileURL)
            self.selectedImages.append(self.allPhotos[indexPath.item].image)
            self.collectionView.insertItems(at: [indexPath])
            self.title = "\(self.selectedPhotos.count) " + "keyword.itemSelected".localized
        })
        imagePickerHelper?.didStartCamera = .some({ [weak self] in
            guard let self = self else { return }
            self.cameraMode = true
        })
    }

    private func checkThePreviousSelectedPhotos() {
        selectedPhotos.removeAll()
        selectedUrls.removeAll()
        selectedImages.removeAll()

        for (index, image) in allPhotos.enumerated() {
            if selectedPhotos.contains(where: { return $0.image == image.image}) {
                allPhotos[index].isSelected = true
            } else {
                allPhotos[index].isSelected = false
            }
        }
        collectionView.reloadData()
    }

    // MARK: photokit functions
    fileprivate func setupPhotoAsset() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = true
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        allPhotosAssetResults = PHAsset.fetchAssets(with: fetchOptions)
        if let image = UIImage(named: "ic_camera_button") {
            allPhotos.insert(.init(image: image, isDownloading: false, progress: 0, isSelected: false), at: 0)
            assets.append(.init())
        }
        cameraOffset = 1
        getPhotos()
    }

    fileprivate func setupAlbumAsset() {
        guard let album = album else { return }
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = true
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        allPhotosAssetResults = PHAsset.fetchAssets(in: album.collection, options: fetchOptions)
        selectedPhotos.removeAll()
        selectedUrls.removeAll()
        selectedImages.removeAll()
        allPhotos.removeAll()
        assets.removeAll()
        collectionView.reloadData()
        beginIndex = 0
        endIndex = 9
        hasNextPage = false
        loading = false
        if album.count == 0 {
            emptyView.addToParent(view, with: "keyword.noResults".localized)
        } else {
            emptyView.removeFromParent()
            activityIndicator.startAnimating()
            cameraOffset = 0
            getPhotos()
        }
        titleLabel.text = album.name
    }

    private func getPhotos() {
        guard let allPhotosAssetResults = allPhotosAssetResults else { return }
        endIndex = beginIndex + (page - 1)
        if endIndex >= allPhotosAssetResults.count {
            endIndex = allPhotosAssetResults.count - 1
        }
        if endIndex < beginIndex { return }
        let arr = Array(beginIndex...endIndex)

        let indexSet = IndexSet(arr)
        fetchPhotos(indexSet: indexSet)
    }

    fileprivate func fetchPhotos(indexSet: IndexSet) {
        guard let allPhotosAssetResults = allPhotosAssetResults else { return }
        if allPhotosAssetResults.count == allPhotos.count - cameraOffset {
            self.hasNextPage = false
            self.loading = false
            return
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let storngSelf = self else {
                return
            }
            allPhotosAssetResults.enumerateObjects(at: indexSet, options: NSEnumerationOptions.concurrent, using: { (asset, count, _) in
                let imageManager = PHImageManager.default()
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: options, resultHandler: { (image, _) in
                    if let image = image {
                        storngSelf.allPhotos.append(PhotoWrapper(image: image, isDownloading: false, progress: 0, isSelected: false))
                        storngSelf.assets.append(asset)
                    }
                    if (storngSelf.allPhotos.count - 1 - storngSelf.cameraOffset) == indexSet.last! {
                        print("last element")
                        storngSelf.loading = false
                        storngSelf.hasNextPage = storngSelf.allPhotos.count - storngSelf.cameraOffset != allPhotosAssetResults.count
                        storngSelf.beginIndex = storngSelf.allPhotos.count - storngSelf.cameraOffset
                        DispatchQueue.main.async {
                            storngSelf.activityIndicator.stopAnimating()
                            storngSelf.collectionView.reloadData()
                        }
                    }
                })
            })
        }
    }

    fileprivate func selectPhoto(with indexPath: IndexPath) {
        if let maxSelection = maxSelection {
            if selectedImages.count + inDownloadingProgressPhotos.count == maxSelection { return }
        }
        if !allPhotos[indexPath.item].mustDownloadImage {
            guard let fileURL = allPhotos[indexPath.item].image.jpeg(.medium)?.saveImage() else { return }
            allPhotos[indexPath.item].progress = 0
            allPhotos[indexPath.item].isDownloading = false
            allPhotos[indexPath.item].isSelected = true
            selectedPhotos.append(allPhotos[indexPath.item])
            selectedUrls.append(fileURL)
            selectedImages.append(allPhotos[indexPath.item].image)
            collectionView.reloadItems(at: [indexPath])
            title = "\(selectedPhotos.count) " + "keyword.itemSelected".localized
            return
        }
        allPhotos[indexPath.item].isDownloading = true
        inDownloadingProgressPhotos.append(allPhotos[indexPath.item])
        collectionView.reloadItems(at: [indexPath])
        assets[indexPath.item].getURL(progressHandler: { [weak self] (progress, _) in
            guard let weakSelf = self else { return }
            weakSelf.allPhotos[indexPath.item].progress = progress
            let cell = weakSelf.collectionView.cellForItem(at: indexPath) as? PhotoCell
            cell?.updateProgress(progress)
        }) { [weak self] (_, image) in
            guard let weakSelf = self else { return }
            weakSelf.allPhotos[indexPath.item].progress = 0
            weakSelf.allPhotos[indexPath.item].isDownloading = false
            weakSelf.allPhotos[indexPath.item].isSelected = true
            weakSelf.inDownloadingProgressPhotos.removeFirst()
            weakSelf.collectionView.reloadItems(at: [indexPath])
            if let image = image {
                //     let assset = weakSelf.assets[indexPath.item]
                guard let fileURL = image.jpeg(.medium)?.saveImage() else { return }
                weakSelf.selectedUrls.append(fileURL)
                weakSelf.selectedImages.append(image)
                weakSelf.selectedPhotos.append(weakSelf.allPhotos[indexPath.item])
                weakSelf.title = "\(weakSelf.selectedPhotos.count) " + "keyword.itemSelected".localized
            }
        }
    }

    fileprivate func deselectPhoto(with indexPath: IndexPath) {
        allPhotos[indexPath.item].isSelected = false
        allPhotos[indexPath.item].progress = 0
        allPhotos[indexPath.item].isDownloading = false
        collectionView.reloadItems(at: [indexPath])
        var indexToDelete: Int?
        for (index, selectedImage) in selectedPhotos.enumerated() {
            if selectedImage.image == allPhotos[indexPath.item].image {
                indexToDelete = index
            }
        }
        if let index = indexToDelete {
            selectedPhotos.remove(at: index)
            selectedUrls.remove(at: index)
            selectedImages.remove(at: index)
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellId, for: indexPath) as! PhotoCell
        cell.item = allPhotos[indexPath.item]
        if self.hasNextPage && !loading && indexPath.item == self.allPhotos.count - 1 {
            getPhotos()
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 && cameraOffset > 0 {
            imagePickerHelper?.checkCameraAuthorizationStatus()
        } else {
            if allPhotos[indexPath.item].isSelected {
                deselectPhoto(with: indexPath)
            } else {
                selectPhoto(with: indexPath)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if allPhotos[indexPath.item].isSelected {
            deselectPhoto(with: indexPath)
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 3
        return CGSize(width: width, height: width)
    }

    // MARK: Album functions

    private func setupAlbums() {
        let options = PHFetchOptions()
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
        userAlbums.enumerateObjects { (object: AnyObject!, count: Int, _: UnsafeMutablePointer) in
            if object is PHAssetCollection {
                let obj: PHAssetCollection = object as! PHAssetCollection
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                let newAlbum = AlbumModel(name: obj.localizedTitle!, count: obj.estimatedAssetCount, collection: obj)
                self.data.append(newAlbum)
            }
            for (index, _) in self.data.enumerated() {
                self.loadImageFor(indexPath: IndexPath(item: index, section: 0))
            }
        }
    }

    private func loadImageFor(indexPath: IndexPath) {
        let assets = PHAsset.fetchKeyAssets(in: data[indexPath.item].collection, options: PHFetchOptions())
        if let keyAsset = assets?.firstObject {
          let id = fetchAsset(asset: keyAsset, targetSize: .init(width: 120, height: 120)) { (image) in
                if let image = image {
                    self.data[indexPath.item].image = image
                } else {
                    self.fetchFirstImageThumbnail(collection: self.data[indexPath.item].collection, targetSize: .init(width: 120, height: 120)) { (image) in
                        self.data[indexPath.item].image = image
                    }
                }
            }
            self.imageRequestsIDs.append(id)
        }
    }

    private func fetchAsset(asset: PHAsset, targetSize: CGSize, completion: ((UIImage?) -> Void)?) -> PHImageRequestID {
        let options = PHImageRequestOptions()
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        // We could use PHCachingImageManager for better performance here
        return PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .default, options: options, resultHandler: { [weak self] (image, _) in
            guard let _ = self else { return }
            completion?(image)
        })
    }

    private func fetchFirstImageThumbnail(collection: PHAssetCollection, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        // We could sort by creation date here if we want
        let assets = PHAsset.fetchAssets(in: collection, options: PHFetchOptions())
        if let asset = assets.firstObject {
            let id = fetchAsset(asset: asset, targetSize: targetSize, completion: completion)
            self.imageRequestsIDs.append(id)
        } else {
            completion(nil)
        }
    }

    // MARK: Selector functions
    @objc
    fileprivate func performDoneBarButtonAction() {
        delegate?.photosCollectionViewController(self, didFinishPicking: selectedUrls, images: selectedImages)
    }

    @objc
    fileprivate func performCancelBarButtonAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    fileprivate func performAlbumButtonAction() {
        let viewController = AlbumViewController()
        viewController.updatePopOverViewController(albumButton, with: self)
        viewController.delegate = self
        viewController.data = data
        present(viewController, animated: true, completion: nil)
    }
}

extension PhotosCollectionViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension PhotosCollectionViewController: AlbumViewControllerDelegate {
    func albumViewController(albumViewController: AlbumViewController, didSelect album: AlbumModel) {
        self.album = album

        setupAlbumAsset()
        albumViewController.dismiss(animated: true, completion: nil)
    }
}

protocol PhotosCollectionViewControllerDelegate: class {
    func photosCollectionViewController(_ picker: PhotosCollectionViewController, didFinishPicking urls: [URL], images: [UIImage])
}
