//
//  ProductDetailNewViewController.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailNewViewController: BaseViewController {
    
    override var mustHideNavigationBar: Bool {
        true
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    private var productDetailCollectionViewDelegate = ProductDetailCollectionViewDelegate()
    private var productDetailCollectionViewDataSource =  ProductDetailCollectionViewDataSource()

    private var headerView: ProductDetailHeaderCollectionReusableView!
    private let padding: CGFloat = 16
    
    
    lazy var productDetailQuickViewViewController : ProductDetailQuickViewViewController = {
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
    }
    
    private func setupCollectionView(){
        collectionView.register(ProductDetailHeaderCollectionReusableView.self, forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .productDetailHeaderCellId)
        productDetailCollectionViewDataSource.assignViewHeader = { (headerView) in
            self.headerView = headerView
        }
        productDetailCollectionViewDelegate.headerView = headerView
        
        collectionView.delegate = productDetailCollectionViewDelegate
        collectionView.dataSource = productDetailCollectionViewDataSource
        
        productDetailCollectionViewDataSource.productDetailCellDelegate = self
        
        if let layout = collectionView.collectionViewLayout as? CustomPDPLayout {
            layout.minimumLineSpacing = 8 // spacing between 2 cell
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding) // adding inset to the section
        }
        
        addToCartButton.withCornerRadius(12, corners: [.topLeft,.topRight])
    }

    
    @IBAction func addToCart(_ sender: Any){
        
    }
    
    
    
}

extension ProductDetailNewViewController: ProductDetailCollectionViewCellDelegate {
    
    func productDetailCollectionViewCell(_ cell: ProductDetailCollectionViewCell, performAction action: ProductDetailCollectionViewCell.ActionType) {
        changeCurrentContentView(for: action, cell: cell)
    }
}

extension ProductDetailNewViewController {
    
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
