
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
    
    let homeCollectionViewDataSource: HomeCollectionViewDataSource = HomeCollectionViewDataSource()
    let homeCollectionViewFlowLayout: HomeCollectionViewFlowLayout = HomeCollectionViewFlowLayout()
    var homeCollectionViewDelegate:
        HomeCollectionViewDelegate!

    let searchBar = UISearchBar(frame: .zero)
    
    private var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavbar()
        setupViewModel()
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
        homeCollectionViewDataSource.productCellDelegate = self

    }

    
    private  func setupNavbar(){
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search for prodduct..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: .barCodeImage), style: .plain, target: self, action: #selector(barCode))
        
    }
    
    @objc private func barCode(){
        
    }

    private func setupViewModel(){
        homeViewModel = HomeViewModel(dataSource: AppDataSource())
        homeViewModel.delegate = self
        homeViewModel.getHomeData()
    }
    
}

extension HomeViewController: HomeSelectionProtocol{
    func didMoveHomeSlider(to page: Int) {
        homeCollectionViewDataSource.currentPage = page
        collectionView.reloadItems(at: [IndexPath(row: 0, section: 1)])
    }
    
    func didSelect(item at: IndexPath) {
        router?.navigate(to: .adCategoriesRoute)
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


extension HomeViewController: ProductCellDelegate {
    func productCollectionViewCell(_ productCollectionViewCell: ProductCollectionViewCell, perform action: ProductCollectionViewCell.ActionType, with product: Product?) {
        guard let product = product else {
            return
        }
        switch action {
        case .addToCart:
            break
        case .favorite:
            if product.isFavorite == "1" {
                homeViewModel.removeProductFromFavorite(productId:  product.id) {
                    productCollectionViewCell.removeFromFavorite()
                }
            }else{
                homeViewModel.addProductToFavorite(productId: product.id, didAddToFavorite: {
                    productCollectionViewCell.addToFavorite()
                })
            }
        }
    }
    
  
    
}

