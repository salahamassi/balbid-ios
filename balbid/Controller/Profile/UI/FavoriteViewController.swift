//
//  FavoriteViewController.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class FavoriteViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let favoriteTableViewDataSource = FavoriteTableViewDataSource()
    private let addToCartBottomSheet = AddToCartBottomSheet.initFromNib()
    private let addedToCarView = balbid.AddedToCartView.initFromNib()
    private let darkLayer = CALayer()

    
    var favorite: Product?
    var loadFavorite: (() -> Void)?
    var deleteFavorite: ((_ id: Int,_ didRemoveFromFavorite: @escaping ()->Void) -> Void)?
    private var itemAddedToCartDelegate  = ItemAddedToCartDelegate()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupFavoriteTableView()
        setupAddToCartView()
        setupAddedToCartDelegate()
        loadFavorite?()
        setupObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAddedToCartView()
    }
    
    private  func setupNavbar(){
        title = "Favorite"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private  func setupFavoriteTableView(){
        tableView.dataSource = favoriteTableViewDataSource
        favoriteTableViewDataSource.delegate = self
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
            self?.backToHome(selectedIndex: 0)
        }
        itemAddedToCartDelegate.popController = { [weak self] in
            self?.router?.popToRootViewController()
        }
    }
    
    func backToHome(selectedIndex: Int) {
        router?.popToRootViewController()
        guard  let tabBarController = ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? UITabBarController) else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            tabBarController.selectedIndex = selectedIndex
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedToCarView.removeFromSuperview()
        removeDarkView()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAddItemToFavorite), name: .didAddToFavorite, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRemoveItemFromFavorite), name: .didRemoveFromFavorite, object: nil)

    }
    
    @objc func didAddItemToFavorite(notification: NSNotification) {
        guard let product = notification.userInfo?["product"] as? ProductItem,
              let favorite = favoriteTableViewDataSource.favorite else {
            return
        }
        favoriteTableViewDataSource.favorite!.productItems.append(product)
        tableView.insertRows(at: [IndexPath(row: favorite.productItems.count , section: 0)], with: .bottom)
    }
    
    @objc func didRemoveItemFromFavorite(notification: NSNotification) {
        guard let product = notification.userInfo?["product"] as? ProductItem,
              let favorite = favoriteTableViewDataSource.favorite else {
            return
        }
        guard let index = favorite.productItems.firstIndex(of: product) else {
            return
        }
        
        favoriteTableViewDataSource.favorite!.productItems.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index , section: 0)], with: .automatic)
    }


}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func loadFavoriteSuccess(favorite: Product) {
        self.favorite = favorite
        activityIndicator.stopAnimating()
        favoriteTableViewDataSource.favorite = favorite
        tableView.reloadData()
    }
}

extension FavoriteViewController: FavoriteCellDelegate {
    func favoriteCell(_ favoriteCell: FavoriteCell, perform action: FavoriteCell.ActionType, with favoriteItem: ProductItem?) {
        switch action {
        case .addToCart:
              addToCartBottomSheet.show()
        case .delete:
            guard let indexPath = self.tableView.indexPath(for: favoriteCell), let favorite = favorite?.productItems[indexPath.row] else {
                return
            }
            deleteFavorite?(favorite.id, {
                self.favoriteTableViewDataSource.favorite?.productItems.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .none)
                favoriteCell.stopDeleteIndicator()
            })
            break
        }
    }
    
}



