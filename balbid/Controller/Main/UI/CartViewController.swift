//
//  CartViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CartViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cartCollectionViewDataSource: CartCollectionViewDataSource = CartCollectionViewDataSource()
    let cartCollectionViewDelegate: CartCollectionViewDelegate = CartCollectionViewDelegate()
    
    let searchBar = UISearchBar(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupCollectionView()
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
        cartCollectionViewDataSource.count -= 1
        collectionView.deleteItems(at: [indexPath])
    }
    
   
    
}
