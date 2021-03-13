//
//  CartViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CartViewController: BaseViewController {
    
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatore: UIActivityIndicatorView!
    @IBOutlet weak var numberOfProductLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet weak var emptyCartView: UIView!
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
        activityIndicatore.startAnimating()
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
    
    
    @IBAction func pay(_ sender: Any) {
        guard let cart = cartCollectionViewDataSource.cart else {
            return
        }
        router?.navigate(to: CreateOrderRoutes.createOrderRoute(params:["cart" : cart]))
    }
}

extension CartViewController: SwipeActionDelegate {
    func addItemToFavorite(at indexPath: IndexPath) {
        guard let product = cartCollectionViewDataSource.cart?.cartItem[indexPath.row].products else {
            return
        }
        if product.isFavorite ?? "0" == "1" {
            viewModel.removeProductFromFavorite(productId: product.id)
            cartCollectionViewDataSource.cart?.cartItem[indexPath.row].products.isFavorite = "0"
        }else {
            viewModel.addProductToFavorite(productId: product.id)
            cartCollectionViewDataSource.cart?.cartItem[indexPath.row].products.isFavorite = "1"
        }
    }
    
    func deleteItem(at indexPath: IndexPath) {
        guard let id = cartCollectionViewDataSource.cart?.cartItem[indexPath.row].id else {
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
    func emptyCart() {
        activityIndicatore.stopAnimating()

        emptyCartView.isHidden = false
    }
    
    func didAddToFavoriteSuccess() {
        showToast(message: "Added To Favorite success", font: .medium)
    }
    
    func didRemoveFromFavoriteSuccess() {
        showToast(message: "Item Removed From Favorite", font: .medium)
    }
    
    func didUpdateQuantity(quantity: Int,index: Int) {
        let newQunatity = (Int(cartCollectionViewDataSource.cart!.cartItem[index].quantity) ?? 0) + quantity
        cartCollectionViewDataSource.cart!.cartItem[index].quantity = "\(newQunatity)"
    }
    
    func loadCartSuccess(cart: Cart) {
        emptyCartView.isHidden = true
        payButton.isUserInteractionEnabled = true
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
