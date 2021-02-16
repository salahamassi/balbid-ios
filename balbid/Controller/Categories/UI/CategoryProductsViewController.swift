//
//  AdCategoriesViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import SDWebImage


class CategoryProductsViewController: BaseViewController {

    @IBOutlet weak var collectionView: ISIntrinsicCollectionView!
    @IBOutlet weak var activtiyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categoryImageView: UIImageView!

    private let categoryProductsCollectionFlowLayout = CategoryProductsCollectionFlowLayout()
    private  let categoryProductsCollectionDataSource = CategoryProductsCollectionDataSource()
    private let addToCartBottomSheet = AddToCartBottomSheet.initFromNib()
    private let addedToCarView = balbid.AddedToCartView.initFromNib()
    
    var loadProducts: ((Int) -> Void)?
    var deleteFavorite: ((_ id: Int,_ didRemoveFromFavorite: @escaping ()->Void) -> Void)?
    var addToFavorite: ((_ id: Int,_ didAddToFavorite: @escaping ()->Void) -> Void)?
    var category: CategoryItem?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupAddToCartView()
        loadProducts?(111)
        setData()
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
        collectionView.dataSource = categoryProductsCollectionDataSource
        collectionView.delegate = categoryProductsCollectionFlowLayout
        categoryProductsCollectionDataSource.delegate = self
        categoryProductsCollectionFlowLayout.showProductDetail = { [weak self] (row) in
            self?.router?.navigate(to: .productDetailRoute)
        }
        collectionView.register(cells: (nibName: .productCell, cellId: .productCellId))
    }
    
    private func setupAddToCartView(){
        addToCartBottomSheet.addProductsToCart = { [weak self] in
            self?.addToCartBottomSheet.hide()
            self?.addedToCarView.showOrHideView(isOpen: true)
            self?.addDarkView(below: self?.addedToCarView)
        }
    }
    
    private func setupAddedToCartView(){
        addedToCarView.delegate = self
        UIApplication.shared.keyWindow?.addSubview(addedToCarView)
        addedToCarView.setupView()
    }
    
    private func setData(){
        guard let category = category,
              let imageUrl = URL(string: category.image.encodedText ?? "") else {
            return
        }
        categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        categoryImageView.sd_setImage(with: imageUrl)
    }
    
    @IBAction func goToFilter(_ sender: Any){
        router?.navigate(to: .categoriesFilterRoute)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedToCarView.removeFromSuperview()
        removeDarkView()
    }
}


extension CategoryProductsViewController: AddedToCartViewDelegate {
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

extension CategoryProductsViewController: ProductCellDelegate {
    func productCollectionViewCell(_ productCollectionViewCell: ProductCollectionViewCell, perform action: ProductCollectionViewCell.ActionType, with product: ProductItem?) {
        guard  let product = product else {
            return
        }
        switch action {
        case .addToCart:
            showAddToCartView(cell: productCollectionViewCell)
        case .favorite:
            if product.isFavorite == "1" {
                deleteFavorite?(product.id) {
                    productCollectionViewCell.removeFromFavorite()
                }
            }else{
                addToFavorite?(product.id, {
                    productCollectionViewCell.addToFavorite()
                })
            }
        }
        
    }
    
    func showAddToCartView(cell: ProductCollectionViewCell){
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        self.addToCartBottomSheet.show()
    }
    
    
}

extension CategoryProductsViewController: AdCategoriesViewModelDelegate {
    
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func loadProductSuccess(product: Product) {
        categoryProductsCollectionDataSource.product = product
        activtiyIndicator.stopAnimating()
        collectionView.reloadData()
    }
    
    
    
}
