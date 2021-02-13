//
//  AdCategoriesViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class AdCategoriesViewController: BaseViewController {

    @IBOutlet weak var collectionView: ISIntrinsicCollectionView!
    
    let adCategoriesCollectionFlowLayout = AdCategoriesCollectionFlowLayout()
    let adCategoriesCollectionDataSource = AdCategoriesCollectionDataSource()
    private let addToCartBottomSheet = AddToCartBottomSheet.initFromNib()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()

    }
    
    private func setupNavBar(){
        (self.navigationController as! AppNavigationController).restyleBackButton()
        let appIconRightBarButtonItem = UIBarButtonItem(image: UIImage(named:.logoImage), style: .plain, target: nil, action: nil)
        let seachRightBarButtonItem = UIBarButtonItem(image: UIImage(named:.searchImage), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [appIconRightBarButtonItem,seachRightBarButtonItem]
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = adCategoriesCollectionDataSource
        collectionView.delegate = adCategoriesCollectionFlowLayout
        adCategoriesCollectionDataSource.delegate = self
        adCategoriesCollectionFlowLayout.showProductDetail = { [weak self] (row) in
            self?.router?.navigate(to: .productDetailRoute)
        }
        collectionView.register(cells: (nibName: .productCell, cellId: .productCellId))
    }
    
    private func setupAddToCartView(){
    }
    
    @IBAction func goToFilter(_ sender: Any){
        router?.navigate(to: .categoriesFilterRoute)
    }
}



extension AdCategoriesViewController: ProductCellDelegate {
    func productCollectionViewCell(productCollectionViewCell: ProductCollectionViewCell, perform action: ProductCollectionViewCell.ActionType, with product: Product?) {
        switch action {
        case .addToCart:
            showAddToCartView(cell: productCollectionViewCell)
        case .favorite:
            print("add TO Favorite")
        }
    }
    
    func showAddToCartView(cell: ProductCollectionViewCell){
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        self.addToCartBottomSheet.show()
    }
    
    
}
