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
    let homeCollectionViewDelegate: HomeCollectionViewDelegate = HomeCollectionViewDelegate()

    let searchBar = UISearchBar(frame: .zero)
    
    private var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavbar()
        setupViewModel()
    }
        
    private func setupCollectionView(){
        collectionView.dataSource = homeCollectionViewDataSource
        collectionView.collectionViewLayout = homeCollectionViewFlowLayout.setupFlowLayout()
        homeCollectionViewDelegate.delegate = self
        collectionView.delegate = homeCollectionViewDelegate
        collectionView.register(UINib(nibName: .productHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .productHeaderCellId)
        
        collectionView.register(UINib(nibName: .wholeSaleOfferHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .wholesaleOffersHeaderCellId)
        
        collectionView.register(UINib(nibName: .strongestOfferHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .strongestOfferProductHeaderCellId)
        
        collectionView.register(UINib(nibName: .productCell, bundle: nil), forCellWithReuseIdentifier: .productCellId)
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
    func didSelect(item at: IndexPath) {
        router?.navigate(to: .adCategoriesRoute)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func loadHomeSuccess() {
        activityIndicator.stopAnimating()
        homeCollectionViewDataSource.numberOfSection = 13
        collectionView.reloadData()
    }
    
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    
}
