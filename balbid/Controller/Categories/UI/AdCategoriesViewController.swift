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
    private let addedToCarView = balbid.AddedToCartView.initFromNib()
    let darkLayer = CALayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupAddToCartView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
        setupAddedToCartView()
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
        addToCartBottomSheet.addProductsToCart = { [weak self] in
            self?.addToCartBottomSheet.hide()
            self?.addedToCarView.showOrHideView(isOpen: true)
            self?.addDarkView()
        }
    }
    
    private func setupAddedToCartView(){
        addedToCarView.delegate = self
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedToCarView.removeFromSuperview()
        removeDarkView()
    }
}


extension AdCategoriesViewController: AddedToCartViewDelegate {
    func AddedToCartView(_ addedToCartView: AddedToCartView, perform actionType: AddedToCartView.ActionType) {
        switch actionType {
        case .continueShopping:
            addedToCartView.showOrHideView(isOpen: false)
            removeDarkView()
        case .pay:
            addedToCartView.showOrHideView(isOpen: false)
            router?.popToRootViewController()
            guard let tabBarController = ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? UITabBarController) else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                tabBarController.selectedIndex = 3
            }
        
        }
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

