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
        cartCollectionViewDataSource.cartDelegate = self
    }
    
}

extension CartViewController: SwipeActionDelegate {
    func addItemToFavorite(at indexPath: IndexPath) {
        
    }
    
    func deleteItem(at indexPath: IndexPath) {
        guard let id = cartCollectionViewDataSource.cart?.cartItem[indexPath.row].id,
              let cart = cartCollectionViewDataSource.cart else {
            return
        }
        viewModel.deleteFromCart(id: id, index: indexPath.row)
//        numberOfProductLabel.text = "\(cart.cartItem.count - 1) Product"
//        let newTotalPrice = total - deletedPrice
//        totalPriceLabel.text = "\(newTotalPrice)" + " SAR"
//        cartCollectionViewDataSource.cart?.total = "\(newTotalPrice)"
    }

}


extension CartViewController: CartViewModelDelegate {
    func didUpdateQuantity(quantity: Int,index: Int) {
        cartCollectionViewDataSource.cart!.cartItem[index].quantity = "\(quantity)"
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func loadCartSuccess(cart: Cart) {
        activityIndicatore.stopAnimating()
        cartCollectionViewDataSource.cart = cart
        numberOfProductLabel.text = "\(cart.cartItem.count) Product"
        totalPriceLabel.text = cart.total + " SAR"
        collectionView.reloadData()
    }
    
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    
    func didDeleteSuccessfully(index: Int) {
        cartCollectionViewDataSource.cart?.cartItem.remove(at: index)
        collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
        viewModel.getCartData()
    }
    
}


extension CartViewController: CartCollectionViewCellDelegate {
    func changeQuantity(_ cell: CartCollectionViewCell, to newQuantity: Int, didComplete: @escaping () -> Void) {
        guard let indexPath = collectionView.indexPath(for: cell),
              let id = cartCollectionViewDataSource.cart?.cartItem[indexPath.row].id else {
            return
        }
        viewModel.updateProductQuantity(id: id, quantity: newQuantity, index: indexPath.row, didUpdateQuantity: {
            didComplete()
        })
    }
}
