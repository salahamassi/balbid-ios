//
//  AdCategoriesViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import SDWebImage
import CCBottomRefreshControl

class CategoryProductsViewController: BaseViewController {

    @IBOutlet weak var collectionView: ISIntrinsicCollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activtiyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categoryImageView: UIImageView!

    private let categoryProductsCollectionFlowLayout = CategoryProductsCollectionFlowLayout()
    private  let categoryProductsCollectionDataSource = CategoryProductsCollectionDataSource()
    private let addToCartBottomSheet = AddToCartBottomSheet.initFromNib()
    private let addedToCarView = balbid.AddedToCartView.initFromNib()
    
    var loadProducts: ((Int,Bool) -> Void)?
    var deleteFavorite: ((_ id: Int,_ didRemoveFromFavorite: @escaping ()->Void) -> Void)?
    var addToFavorite: ((_ id: Int,_ didAddToFavorite: @escaping ()->Void) -> Void)?
    var category: CategoryItem?
    private var isVerticalScrolling = true
    private var lastContentOffset : CGFloat = 0
    
    private var productDelegate = ProductDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupAddToCartView()
        loadProducts?(category?.id ?? -1,false)
        setData()
        setupProductDelegate()
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
        categoryProductsCollectionDataSource.delegate = productDelegate
        categoryProductsCollectionFlowLayout.showProductDetail = { [weak self] (row) in
            self?.router?.navigate(to: .productDetailRoute)
        }
        collectionView.register(cells: (nibName: .productCell, cellId: .productCellId))
    }
    
    private func setupProductDelegate() {
        productDelegate.deleteFavorite = deleteFavorite
        productDelegate.addToFavorite = addToFavorite
        productDelegate.showAddToCartView = { [weak self] cell in
            self?.showAddToCartView(cell: cell)
        }
    }
    
    
    @objc
    private func paginateMore() {
        print("New Pagination")
        loadProducts?(category?.id ?? -1,true)

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
        categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        guard let category = category,
              let imageUrl = URL(string: category.image.encodedText ?? "") else {
            return
        }
        categoryImageView.sd_setImage(with: imageUrl)
    }
    
    @IBAction func goToFilter(_ sender: Any){
        router?.navigate(to: .categoriesFilterRoute)
    }
    
    func showAddToCartView(cell: ProductCollectionViewCell){
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        self.addToCartBottomSheet.show()
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


extension CategoryProductsViewController: AdCategoriesViewModelDelegate {
    func didLoadNewPaginate(product: Product) {
        categoryProductsCollectionDataSource.product?.productItems.append(contentsOf: product.productItems)
    }
    
    
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func loadProductSuccess(product: Product) {
        categoryProductsCollectionDataSource.product = product
        activtiyIndicator.stopAnimating()
        collectionView.reloadData()

    }
    
}


extension CategoryProductsViewController : UIScrollViewDelegate {
    //call pagination function when user scroll down
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (self.lastContentOffset > scrollView.contentOffset.x) {
//            isVerticalScrolling = false
//        } else if (self.lastContentOffset < scrollView.contentOffset.x) {
//            isVerticalScrolling = false
//        }else if (self.lastContentOffset > scrollView.contentOffset.y){
//            isVerticalScrolling = false
//        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            isVerticalScrolling = true
//        }
//
//        self.lastContentOffset = scrollView.contentOffset.x;

//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            paginateMore()
        }
    }
}
