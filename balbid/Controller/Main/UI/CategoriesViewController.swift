//
//  CategoriesViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 31/12/2020.
//

import UIKit

class CategoriesViewController: BaseViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var categoriesContentCollectionView: UICollectionView!

    let categoriesTableViewDataSource = CategoriesTableViewDataSource()
    let categoriesContentCollectionViewDataSource = CategoriesContentCollectionViewDataSource()
    let categoriesContentCollectionViewFloawLayout = CategriesContentCollectionViewFlowLayout()

    let searchBar = UISearchBar(frame: .zero)


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoriesTableView()
        setupCategoriesContentCollectionView()
        setupNavbar()
    }
    
    private func setupCategoriesTableView(){
        categoriesTableView.estimatedRowHeight = 14
        categoriesTableView.rowHeight = UITableView.automaticDimension
        categoriesTableView.dataSource = categoriesTableViewDataSource
    }
    
    private func setupCategoriesContentCollectionView(){
        categoriesContentCollectionView.dataSource = categoriesContentCollectionViewDataSource
        categoriesContentCollectionView.collectionViewLayout = categoriesContentCollectionViewFloawLayout.setupFlowLayout()
        categoriesContentCollectionView.register(UINib(nibName: .categoryContentHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .categoryContentHeaderCellId)
        categoriesContentCollectionViewDataSource.delegate = self
    }

    private func setupNavbar(){
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search for prodduct..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: .barCodeImage), style: .plain, target: self, action: #selector(barCode))
    }
    
    @objc private func barCode(){
        
    }
}

extension CategoriesViewController: ChangableRowDelegate {
    func toggleRows(at section: Int, isExpand: Bool) {
        var indexPathes: [IndexPath] = []
        for i in 0..<5 {
            indexPathes.append(IndexPath(row: i, section: section))
        }
        if isExpand {
            categoriesContentCollectionView.insertItems(at: indexPathes)
        }else{
            categoriesContentCollectionView.deleteItems(at: indexPathes)
        }
    }
}
