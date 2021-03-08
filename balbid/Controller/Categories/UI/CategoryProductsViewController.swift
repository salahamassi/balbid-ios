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
    @IBOutlet weak var paginateActivtiyIndicator: UIActivityIndicatorView!
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
    private var itemAddedToCartDelegate  = ItemAddedToCartDelegate()
    private var paginateDelegate = PaginateDelegate()
    private  var canPginate = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupAddToCartView()
//        loadProducts?(category?.id ?? -1,false)
        loadProducts?(15,false)
        setData()
        setupProductDelegate()
        setupAddedToCartDelegate()
        setupScrollDelegate()
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
            guard let product =  self?.categoryProductsCollectionDataSource.product?.productItems[row] else {
                return
            }
            self?.router?.navigate(to: ProductRoutes.productDetailRoute(params: ["product": product]))
        }
        collectionView.register(cells: (nibName: .productCell, cellId: .productCellId))
        collectionView.register(UINib(nibName: .categoryFooterView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: .categoryProductFooterCellId)
    }
    
    private func setupScrollDelegate(){
        scrollView.delegate = paginateDelegate
        paginateDelegate.paginate = {  [weak self] in
            if self?.canPginate ?? false {
                self?.canPginate = false
                self?.categoryProductsCollectionFlowLayout.isPaginate = true
                self?.collectionView.reloadSections(.init(integer: 0))
                self?.paginateMore()
            }
        }
    }
    
    private func setupProductDelegate() {
        productDelegate.deleteFavorite = deleteFavorite
        productDelegate.addToFavorite = addToFavorite
        productDelegate.showAddToCartView = { [weak self] cell in
            self?.showAddToCartView(cell: cell)
        }
    }
    
    private func setupAddedToCartDelegate() {
        itemAddedToCartDelegate.continueShopping = { [weak self] in
            self?.removeDarkView()
        }
        itemAddedToCartDelegate.popController = { [weak self] in
            self?.router?.popToRootViewController()
        }
    }
    
    private func paginateMore() {
        loadProducts?(15,true)
    }
    
    private func setupAddToCartView(){
        addToCartBottomSheet.addProductsToCart = { [weak self] total in
            self?.addedToCarView.total = total
            self?.addToCartBottomSheet.hide()
            self?.addedToCarView.showOrHideView(isOpen: true)
            self?.addDarkView(below: self?.addedToCarView)
        }
        
        addToCartBottomSheet.failedToAdd = {  [weak self] message in
            self?.displayAlert(message: message)
        }
    }
    
    private func setupAddedToCartView(){
        addedToCarView.delegate = itemAddedToCartDelegate
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
        guard let indexPath = self.collectionView.indexPath(for: cell),
              let product = categoryProductsCollectionDataSource.product?.productItems[indexPath.row]  else {
            return
        }
        addToCartBottomSheet.product = product
        self.addToCartBottomSheet.show()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedToCarView.removeFromSuperview()
        removeDarkView()
    }
}

extension CategoryProductsViewController: AdCategoriesViewModelDelegate {
    func didLoadNewPaginate(product: Product) {
        let preLastIndex =  categoryProductsCollectionDataSource.product?.productItems.count ?? 0
        categoryProductsCollectionDataSource.product?.productItems.append(contentsOf: product.productItems)
        let count =  categoryProductsCollectionDataSource.product?.productItems.count ?? 0
        var indexPath: [IndexPath] = []
        for i in preLastIndex..<count {
            indexPath.append(IndexPath(row: i, section: 0))
        }
        canPginate = product.productItems.count != 0
        categoryProductsCollectionFlowLayout.isPaginate = false
        collectionView.insertItems(at: indexPath)
       
//        collectionView.reloadSections(.init(integer: 0))
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
