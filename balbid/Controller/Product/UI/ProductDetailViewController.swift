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
    
    
    var product:  ProductItem!
    var loadProduct: ((Int)-> Void)?
    
    
    lazy var productDetailQuickViewViewController: ProductDetailQuickViewViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailQuickViewViewController) as! ProductDetailQuickViewViewController
        return viewController
    }()
    
    lazy var productDetailRateViewController : ProductDetailRateViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailRateViewController) as! ProductDetailRateViewController
        return viewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadProduct?(product.id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupCollectionView(){
       collectionView.register(ProductDetailHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: .productDetailHeaderCellId)
        
        productDetailCollectionViewDataSource.assignViewHeader = { (headerView) in
            self.headerView = headerView
        }
        productDetailCollectionViewDelegate.headerView = headerView
        
        collectionView.delegate = productDetailCollectionViewDelegate
        collectionView.dataSource = productDetailCollectionViewDataSource
        
        
        collectionView.contentInsetAdjustmentBehavior = .always
        productDetailCollectionViewDataSource.productDetailCellDelegate = self
        productDetailCollectionViewDataSource.productDetailHeaderCollectionReusableViewDelegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 8 // spacing between 2 cell
//            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding) // adding inset to the section
        }
        
        addToCartButton.withCornerRadius(12, corners: [.topLeft,.topRight])
    }

    
    @IBAction func addToCart(_ sender: Any){
        
    }
    
    
}

extension ProductDetailViewController: ProductDetailCollectionViewCellDelegate {
    func productDetailCollectionViewCell(_ cell: ProductDetailCollectionViewCell, performAction action: ProductDetailCollectionViewCell.ActionType) {
        changeCurrentContentView(for: action, cell: cell)
    }
}

extension ProductDetailViewController: ProductDetailHeaderCollectionReusableViewDelegate {
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
        add(productDetailQuickViewViewController, to: cell.containerView, frame: cell.containerView.frame)
    }

    private func addProductDetailRateViewController(to cell: ProductDetailCollectionViewCell) {
        productDetailQuickViewViewController.remove()
        add(productDetailRateViewController, to: cell.containerView, frame: cell.containerView.frame)
    }

}

extension ProductDetailViewController: ProductViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didLoadProductSuccess(product: ProductItem) {
        self.product =  product
        headerView.images = product.images
        productDetailCollectionViewDataSource.product = product
        collectionView.reloadData()
    }
    
    
    
}
