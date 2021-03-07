//
//  ProductDetailNewViewController.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    
    override var mustHideNavigationBar: Bool {
        true
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addToCartButton: UIButton!

    
    private var productDetailCollectionViewDelegate = ProductDetailCollectionViewDelegate()
    private var productDetailCollectionViewDataSource =  ProductDetailCollectionViewDataSource()

    private var headerView: ProductDetailHeaderView!
    private let padding: CGFloat = 16
    private let colorSelectionView = ColorSelectionView.initFromNib()
    
    
    var product:  ProductItem!
    var loadProduct: ((Int)-> Void)?
    
    
    lazy var productDetailQuickViewViewController: ProductDetailQuickViewViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailQuickViewViewController) as! ProductDetailQuickViewViewController
        return viewController
    }()
    
    lazy var productDetailRateViewController : ProductDetailRateViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailRateViewController) as! ProductDetailRateViewController
        viewController.productId  = product.id
        viewController.didPaginateSuccess = { [weak self] in
            self?.updateCellAccordingToRateViewPaginate()
        }
        return viewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadProduct?(product.id)
    }
    
    private func setupView() {
        setupCollectionView()
        addToCartButton.withCornerRadius(12, corners: [.topLeft,.topRight])
    }
    
    private func setupCollectionView(){
   
        setupCollectionHeaderView()
        collectionView.delegate = productDetailCollectionViewDelegate
        collectionView.dataSource = productDetailCollectionViewDataSource
        collectionView.contentInsetAdjustmentBehavior = .always
        productDetailCollectionViewDataSource.productDetailCellDelegate = self
        productDetailCollectionViewDataSource.productDetailHeaderCollectionReusableViewDelegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 8
        }
        productDetailCollectionViewDataSource.product = product
    }
    
    private  func setupCollectionHeaderView() {
        collectionView.register(ProductDetailHeaderView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: .productDetailHeaderCellId)
         productDetailCollectionViewDataSource.assignViewHeader = {[weak self] (headerView) in
            guard let self = self else {
                return
            }
            self.headerView = headerView
            self.headerView.images = self.product.images.count == 0 ? [self.product.imageFullPath ?? ""] : self.product.images
         }
         productDetailCollectionViewDelegate.headerView = headerView
    }
    
    private func setupColorSelectionView() {
       let colorOption = product.options.filter({ (group) -> Bool in
            group.optionType == .color
        }).first
        colorSelectionView.optionGroupItem = colorOption
        colorSelectionView.setupSheetView()
    }

    
    @IBAction func addToCart(_ sender: Any){
        
    }
    
    @IBAction func showColorOption(_ sender: Any) {
        colorSelectionView.show()
    }
    
    @IBAction func changePage(_ sender: UIPageControl) {
        headerView.imageCollectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func updateCellAccordingToRateViewPaginate(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.productDetailCollectionViewDelegate.height = 250  + (self.productDetailRateViewController.view.subviews.first?.frame.height ?? .zero)
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}

extension ProductDetailViewController: ProductDetailCollectionViewCellDelegate {
    func productDetailCollectionViewCell(_ cell: ProductDetailCollectionViewCell, performAction action: ProductDetailCollectionViewCell.ActionType) {
        changeCurrentContentView(for: action, cell: cell)
    }
}

extension ProductDetailViewController: ProductDetailHeaderCollectionReusableViewDelegate {
    func ProductDetailHeaderCollectionReusableView(_ cell: ProductDetailHeaderView, didSliderScroll index: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? ProductDetailCollectionViewCell else {
            return
        }
        cell.pageControl.currentPage = index
    }
    
    func ProductDetailHeaderCollectionReusableView(_ cell: ProductDetailHeaderView, performAction action: ProductDetailHeaderView.ActionType) {
        if action == .back {
            router?.popViewController()
        }
    }
}

extension ProductDetailViewController {
    func changeCurrentContentView(for action: ProductDetailCollectionViewCell.ActionType, cell: ProductDetailCollectionViewCell){
        switch action {
        case .quickLook:
            addProductDetailQuickViewViewController(to: cell)
        case .rate:
            addProductDetailRateViewController(to: cell)
        }
    }
    
    private func addProductDetailQuickViewViewController(to cell: ProductDetailCollectionViewCell) {
        productDetailRateViewController.remove()
        productDetailQuickViewViewController.product = product
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            cell.changeContainerViewHeightAccording(to: self.productDetailQuickViewViewController)
            self.add(self.productDetailQuickViewViewController, to: cell.containerView, frame: cell.containerView.frame)
            self.productDetailCollectionViewDelegate.height = 250  + (self.productDetailQuickViewViewController.view.subviews.first?.frame.height ?? .zero )
            self.collectionView.collectionViewLayout.invalidateLayout()

        }
    }

    private func addProductDetailRateViewController(to cell: ProductDetailCollectionViewCell) {
        productDetailQuickViewViewController.remove()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            cell.changeContainerViewHeightAccording(to: self.productDetailRateViewController)
            self.add(self.productDetailRateViewController, to: cell.containerView, frame: cell.containerView.frame)
            self.productDetailCollectionViewDelegate.height = 250  + (self.productDetailRateViewController.view.subviews.first?.frame.height ?? .zero  + 40)
            self.collectionView.collectionViewLayout.invalidateLayout()

        }
    }

}

extension ProductDetailViewController: ProductViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didLoadProductSuccess(product: ProductItem) {
        self.product =  product
        headerView.images = product.images.count == 0 ? [product.imageFullPath ?? ""] : product.images
        productDetailCollectionViewDataSource.product = product
        collectionView.reloadData()
        setupColorSelectionView()
    }
}
