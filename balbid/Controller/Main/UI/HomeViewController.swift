
//
//  HomeViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 26/12/2020.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let homeCollectionViewDataSource: HomeCollectionViewDataSource = HomeCollectionViewDataSource()
    private let homeCollectionViewFlowLayout: HomeCollectionViewFlowLayout = HomeCollectionViewFlowLayout()
    private var homeCollectionViewDelegate:
        HomeCollectionViewDelegate!
    private let searchBar = UISearchBar(frame: .zero)
    private var homeViewModel: HomeViewModel!
    private var productDelegate = ProductDelegate()
    private let addToCartBottomSheet = AddToCartBottomSheet.initFromNib()
    private let addedToCarView = balbid.AddedToCartView.initFromNib()
    private var itemAddedToCartDelegate  = ItemAddedToCartDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavbar()
        setupViewModel()
        setupProductDelegate()
        setupAddToCartView()
        setupAddedToCartDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAddedToCartView()
    }
        
    fileprivate func registerCell() {
        collectionView.register(UINib(nibName: .productHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .productHeaderCellId)
        
        collectionView.register(UINib(nibName: .wholeSaleOfferHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .wholesaleOffersHeaderCellId)
        
        collectionView.register(UINib(nibName: .strongestOfferHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .strongestOfferProductHeaderCellId)
        
        collectionView.register(UINib(nibName: .productCell, bundle: nil), forCellWithReuseIdentifier: .productCellId)
        
        collectionView.register(UINib(nibName: .productFooter, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: .productFooterCellId)
    }
    
    private func setupCollectionView(){
        homeCollectionViewDelegate = HomeCollectionViewDelegate(collectionView: collectionView)
        collectionView.dataSource = homeCollectionViewDataSource
        collectionView.collectionViewLayout = homeCollectionViewFlowLayout.setupFlowLayout()
        homeCollectionViewDelegate.delegate = self
        collectionView.delegate = homeCollectionViewDelegate
        registerCell()
        homeCollectionViewDataSource.delegate = self
        homeCollectionViewDataSource.productCellDelegate = productDelegate

    }
    
    private func setupProductDelegate() {
        productDelegate.deleteFavorite = homeViewModel.removeProductFromFavorite
        productDelegate.addToFavorite = homeViewModel.addProductToFavorite
        productDelegate.showAddToCartView = { [weak self] cell in
            self?.showAddToCartView(cell: cell)
        }
    }
    
    
    private  func setupNavbar(){
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search for prodduct..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: .barCodeImage), style: .plain, target: self, action: #selector(barCode))
        
    }
    
    @objc private func barCode(){
        
    }
    
    private func showAddToCartView(cell: ProductCollectionViewCell){
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        self.addToCartBottomSheet.show()
    }
    
    private func setupAddToCartView(){
        addToCartBottomSheet.addProductsToCart = { [weak self] in
            self?.addToCartBottomSheet.hide()
            self?.addedToCarView.showOrHideView(isOpen: true)
            self?.addDarkView(below: self?.addedToCarView)
        }
    }
    
    private func setupAddedToCartView(){
        addedToCarView.delegate = itemAddedToCartDelegate
        UIApplication.shared.keyWindow?.addSubview(addedToCarView)
        addedToCarView.setupView()
    }
    
    
    private func setupAddedToCartDelegate() {
        itemAddedToCartDelegate.continueShopping = { [weak self] in
            self?.removeDarkView()
        }
        itemAddedToCartDelegate.popController = { [weak self] in
            self?.router?.popToRootViewController()
        }
    }
    
    private func setupViewModel(){
        homeViewModel = HomeViewModel(dataSource: AppDataSource())
        homeViewModel.delegate = self
        homeViewModel.getHomeData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedToCarView.removeFromSuperview()
        removeDarkView()
    }
    
}

extension HomeViewController: HomeSelectionProtocol{
    func didSelectItem(at indexPath: IndexPath) {
        if indexPath.section != 0 && indexPath.section != 1 {
            guard let product = homeViewModel.home?.homeProductItems[indexPath.section].prodcuts[indexPath.row] else {
                return
            }
            router?.navigate(to: ProductRoutes.productDetailRoute(params: ["product": product]))
        }
    }
    
    func didMoveHomeSlider(to page: Int) {
        homeCollectionViewDataSource.currentPage = page
        collectionView.reloadItems(at: [IndexPath(row: 0, section: 1)])
    }
  
}

extension HomeViewController: HomeViewModelDelegate {
    func loadHomeSuccess(home: Home) {
        activityIndicator.stopAnimating()
        homeCollectionViewDataSource.numberOfSection = 2 + home.homeProductItems.count
        homeCollectionViewDataSource.home = home
        collectionView.reloadData()

        homeCollectionViewFlowLayout.sectionWithFooters = home.banners.map {
            (Int($0.sortOrder) ?? 0) + 1
        }
        
    }
    
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    
}


extension HomeViewController: SliderIndicatorCollectionViewCellDelegate {
    func didChangePage(to page: Int) {
        collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
    }    
}

