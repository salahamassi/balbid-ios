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

    
    let favoriteTableViewDataSource = FavoriteTableViewDataSource()
    
    var loadFavorite: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupFavoriteTableView()
        loadFavorite?()
    }
    
    private  func setupNavbar(){
        title = "Favorite"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private  func setupFavoriteTableView(){
        tableView.dataSource = favoriteTableViewDataSource
    }
    


}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func loadFavoriteSuccess(favorite: Favorite) {
        activityIndicator.stopAnimating()
        favoriteTableViewDataSource.favorite = favorite
        tableView.reloadData()
    }
    
    
}
