//
//  PhotosPreviewViewController.swift
//  MSA
//
//  Created by Salah Nahed on 3/11/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import VICMAImageView
import UIKit

class PhotosPreviewViewController: AppViewController<PhotosPreviewView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusBarStyle
    }
    
    private var statusBarStyle: UIStatusBarStyle = .lightContent
    
    var medias: [MediaWrapper]
    var currentIndex: Int?
    
    let mustHideDeleteButton: Bool
    var delegate: PhotosPreviewViewControllerDelegate?
    
    let fakeImageView = VICMAImageView()
    
    init(router: AppRouter, medias:  [MediaWrapper], currentIndex: Int, mustHideDeleteButton: Bool, delegate: PhotosPreviewViewControllerDelegate? = nil) {
        self.medias = medias
        self.currentIndex = currentIndex
        self.mustHideDeleteButton = mustHideDeleteButton
        self.delegate = delegate
        super.init(router: router)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let photosPreviewView = PhotosPreviewView()
        view = photosPreviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsProperties()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 13.0, *) {
            statusBarStyle = .darkContent
        } else {
            statusBarStyle = .lightContent
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setViewsProperties() {
        let collectionView = customView.collectionView
        customView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        customView.counterLabel.text = "1/\(medias.count)"
        customView.deleteButton.alpha = mustHideDeleteButton ? 0 : 1
        customView.collectionView.register(cells: (cellClass: PhotoPreviewCell.self, cellId: .photoPreviewCellId))
    }
    
    @objc
    private func handleViewPanGestureRecognizer(_ gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            handleViewPanBegan()
        }else if gesture.state == .changed{
            handleViewPanChanged(gesture)
        }else if gesture.state == .ended{
            handleViewPanEnded(gesture)
        }
    }
    
    private func handleViewPanBegan(){
        guard let cell = customView.collectionView.visibleCells.first as?  PhotoPreviewCell else { return }
        guard let cellFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        fakeImageView.image = cell.photoImageView.image
        fakeImageView.contentMode = .scaleAspectFit
        fakeImageView.clipsToBounds = true
        fakeImageView.frame = cellFrame
        if !view.subviews.contains(fakeImageView){
            view.addView(fakeImageView)
        }
        toogleViews()
    }
    
    private func handleViewPanChanged(_ gesture: UIPanGestureRecognizer){
        let blackMaskView = customView.blackMaskView
        let translation = gesture.translation(in: view)
        let finalScale = 1 - abs(translation.y) / blackMaskView.frame.height
        if finalScale <= 0.2 { return }
        fakeImageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y).scaledBy(x: finalScale, y: finalScale)
        blackMaskView.alpha = 1 - abs(translation.y) / 200
    }
    
    private func handleViewPanEnded(_ gesture: UIPanGestureRecognizer){
        let blackMaskView = customView.blackMaskView
        guard let transitioningDelegate = transitioningDelegate as? PhotosPreviewViewControllerPresentDismissAnimator else { return }
        guard let mediaContainerView = transitioningDelegate.mediaContainerView  else { return }
        guard let startFrame = mediaContainerView.mediaView.superview?.convert(mediaContainerView.mediaView.frame, to: view)  else { return }
        
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if translation.y > 120 || translation.y < -120 || velocity.y > 120 || velocity.y < -120{
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.fakeImageView.contentMode = .scaleAspectFill
                self.fakeImageView
                    .withFrame(startFrame)
                    .withCornerRadius(8, corners:  [.topRight, .bottomLeft, .bottomRight])
                blackMaskView.alpha = 0
            }) { (bool) in
                mediaContainerView.mediaView.alpha = 1
                self.fakeImageView.removeFromSuperview()
                self.router?.dismiss(animated: false, completion: nil)
            }
        }else{
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.fakeImageView.transform = .identity
                blackMaskView.alpha = 1
            }) { (bool) in
                self.toogleViews()
                self.fakeImageView.removeFromSuperview()
            }
        }
    }
    
    func toogleViews(){
        let topView = customView.topView
        let collectionView = customView.collectionView
        let counterLabel = customView.counterLabel
        topView.isHidden = !topView.isHidden
        collectionView.isHidden = !collectionView.isHidden
        collectionView.reloadData()
        if let currentIndex = currentIndex{
            counterLabel.text = "\(currentIndex + 1)/\(medias.count)"
            collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: false, scrollPosition: .left)
        }
        currentIndex = nil
    }
    
    private func performBackButtonAction(){
        router?.dismiss(animated: true, completion: nil)
    }
    
    private func performRemoveImageButtonAction(){
        let collectionView = customView.collectionView
        let counterLabel = customView.counterLabel
        guard let currentCell = collectionView.visibleCells.first else { return }
        guard let currentIndexPath = collectionView.indexPath(for: currentCell) else { return }
        medias.remove(at: currentIndexPath.item)
        collectionView.deleteItems(at: [currentIndexPath])
        let indexPath = IndexPath(item: currentIndexPath.item + 1, section: 0)
        delegate?.photosPreviewViewController(self, didDeleteImageAt: indexPath)
        if medias.isEmpty{
            performBackButtonAction()
        }else if medias.count == 1{
            counterLabel.text = "\(1)/\(self.medias.count)"
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
                guard let currentCell = collectionView.visibleCells.first else { return }
                guard let currentIndexPath = collectionView.indexPath(for: currentCell) else { return }
                counterLabel.text = "\(currentIndexPath.item + 1)/\(self.medias.count)"
            }
        }
    }
}

extension PhotosPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .photoPreviewCellId, for: indexPath) as! PhotoPreviewCell
        cell.item = medias[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item: Int
        if Locale.current.languageCode == "ar"{
            let value = (scrollView.frame.size.width * CGFloat(medias.count - 1))
            item = Int((value - targetContentOffset.pointee.x) / scrollView.frame.width)
        }else{
            item = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        }
        customView.counterLabel.text = "\(item + 1)/\(medias.count)"
        delegate?.photosPreviewViewController(self, didDisplayImageFrom: medias[item].indexPath)
    }
}

extension PhotosPreviewViewController: PhotosPreviewViewDelegate{
    
    func photosPreviewView(_ photosPreviewView: PhotosPreviewView, performBackButtonAction button: UIButton) {
        performBackButtonAction()
    }
    
    func photosPreviewView(_ photosPreviewView: PhotosPreviewView, performRemoveImageButtonAction button: UIButton) {
        performRemoveImageButtonAction()
    }
    
    func photosPreviewView(_ photosPreviewView: PhotosPreviewView, handleViewPanGestureRecognizer gesture: UIPanGestureRecognizer) {
        handleViewPanGestureRecognizer(gesture)
    }
    
}

protocol PhotosPreviewViewControllerDelegate: class {
    func photosPreviewViewController(_ photosPreviewViewController: PhotosPreviewViewController, didDeleteImageAt indexPath: IndexPath)
    func photosPreviewViewController(_ photosPreviewViewController: PhotosPreviewViewController, didDisplayImageFrom indexPath: IndexPath)
}

extension PhotosPreviewViewControllerDelegate{
    public func photosPreviewViewController(_ photosPreviewViewController: PhotosPreviewViewController, didDeleteImageAt indexPath: IndexPath){}
    func photosPreviewViewController(_ photosPreviewViewController: PhotosPreviewViewController, didDisplayImageFrom indexPath: IndexPath){}
}
