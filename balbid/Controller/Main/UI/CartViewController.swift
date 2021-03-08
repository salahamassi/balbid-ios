//
//  CartViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CartViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatore: UIActivityIndicatorView!
    @IBOutlet weak var numberOfProductLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    let cartCollectionViewDataSource: CartCollectionViewDataSource = CartCollectionViewDataSource()
    let cartCollectionViewDelegate: CartCollectionViewDelegate = CartCollectionViewDelegate()
    
    let searchBar = UISearchBar(frame: .zero)
    private var viewModel: CartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViewModel()
    }
    
  
    private func  setupViewModel() {
        viewModel = CartViewModel(appDataSource: AppDataSource())
        viewModel.delegate = self
        viewModel.getCartData()
    }
    
    
    private func setupNavbar(){
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search for prodduct..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: .barCodeImage), style: .plain, target: self, action: nil)
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = cartCollectionViewDataSource
        collectionView.delegate = cartCollectionViewDelegate
        cartCollectionViewDataSource.delegate = self
    }
    
}

extension CartViewController: SwipeActionDelegate {
    func addItemToFavorite(at indexPath: IndexPath) {
        
    }
    
    func deleteItem(at indexPath: IndexPath) {
//        cartCollectionViewDataSource.count -= 1
//        collectionView.deleteItems(at: [indexPath])
    }
    
   
    
}


extension CartViewController: CartViewModelDelegate {
    func loadCartSuccess(cart: Cart) {
        activityIndicatore.stopAnimating()
        cartCollectionViewDataSource.cart = cart
        numberOfProductLabel.text = "\(cart.cartItem.count) Product"
        totalPriceLabel.text = cart.total + " RS"
        collectionView.reloadData()
    }
    
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    
}
