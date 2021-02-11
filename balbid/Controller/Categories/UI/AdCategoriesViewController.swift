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
    private let addedToCarView = AddedToCartView.initFromNib()
    let darkLayer = CALayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupAddToCartView()
        setupAddedToCartView()
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
        adCategoriesCollectionDataSource.openCartSheet = { [weak self] (cell) in
            guard let indexPath = self?.collectionView.indexPath(for: cell) else {
                return
            }
            self?.addToCartBottomSheet.show()
            
        }
        adCategoriesCollectionFlowLayout.showProductDetail = { [weak self] (row) in
            self?.router?.navigate(to: .productDetailRoute)
        }
        collectionView.register(cells: (nibName: .productCell, cellId: .productCellId))
    }
    
    private func setupAddToCartView(){
        addToCartBottomSheet.addProductsToCart = { [weak self] in
            self?.addToCartBottomSheet.hide()
            self?.addedToCarView.showView()
            self?.addDarkView()
        }
    }
    
    private func setupAddedToCartView(){
        UIApplication.shared.keyWindow?.addSubview(addedToCarView)
        addedToCarView.setupView()
    }
    
    @IBAction func goToFilter(_ sender: Any){
        router?.navigate(to: .categoriesFilterRoute)
    }
    
    func addDarkView(){
        darkLayer.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.7).cgColor
        darkLayer.frame = UIScreen.main.bounds
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.layer.insertSublayer(self.darkLayer, below: self.addedToCarView.layer)
        }
    }
    
    func removeDarkView(){
        UIView.animate(withDuration: 0.5) {
            self.darkLayer.removeFromSuperlayer()
        }
    }
}


