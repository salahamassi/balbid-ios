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

    
    var favorite: Favorite?
    var loadFavorite: (() -> Void)?
    var deleteFavorite: ((_ id: Int,_ didRemoveFromFavorite: @escaping ()->Void) -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupFavoriteTableView()
        loadFavorite?()
        setupAddToCartView()
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
        addedToCarView.delegate = self
        UIApplication.shared.keyWindow?.addSubview(addedToCarView)
        addedToCarView.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedToCarView.removeFromSuperview()
        removeDarkView()
    }
    


}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func loadFavoriteSuccess(favorite: Favorite) {
        self.favorite = favorite
        activityIndicator.stopAnimating()
        favoriteTableViewDataSource.favorite = favorite
        tableView.reloadData()
    }
}

extension FavoriteViewController: FavoriteCellDelegate {
    func favoriteCell(_ favoriteCell: FavoriteCell, perform action: FavoriteCell.ActionType, with favoriteItem: FavoriteItem?) {
        switch action {
        case .addToCart:
              addToCartBottomSheet.show()
        case .delete:
            guard let indexPath = self.tableView.indexPath(for: favoriteCell), let favorite = favorite?.favoriteItems[indexPath.row] else {
                return
            }
            deleteFavorite?(favorite.id, {
                self.favoriteTableViewDataSource.favorite?.favoriteItems.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .none)
            })
            break
        }
    }
    

    
}


extension FavoriteViewController: AddedToCartViewDelegate {
    func AddedToCartView(_ addedToCartView: AddedToCartView, perform actionType: AddedToCartView.ActionType) {
        switch actionType {
        case .continueShopping:
            backToHome(selectedIndex: 0)
        case .pay:
            addedToCartView.showOrHideView(isOpen: false)
            backToHome(selectedIndex: 3)
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
}
