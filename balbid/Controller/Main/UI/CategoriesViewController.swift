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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let categoriesTableViewDataSource = CategoriesTableViewDataSource()
    private let categoriesContentCollectionViewDataSource = CategoriesContentCollectionViewDataSource()
    private let categoriesContentCollectionViewFloawLayout = CategriesContentCollectionViewFlowLayout()
    private let categriesContentCollectionViewDelegate = CategriesContentCollectionViewDelegate()

    private let searchBar = UISearchBar(frame: .zero)
    
    
    private var viewModel: CategoriesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoriesTableView()
        setupCategoriesContentCollectionView()
        setupNavbar()
        setupViewModel()
    }
    
    private func setupCategoriesTableView(){
        categoriesTableView.estimatedRowHeight = 14
        categoriesTableView.rowHeight = UITableView.automaticDimension
        categoriesTableView.dataSource = categoriesTableViewDataSource
    }
    
    fileprivate func registerCellForCollectionView() {
        categoriesContentCollectionView.register(UINib(nibName: .categoryContentHeader, bundle: nil), forSupplementaryViewOfKind: .topKind, withReuseIdentifier: .categoryContentHeaderCellId)
    }
    
    private func setupCategoriesContentCollectionView(){
        categoriesContentCollectionView.dataSource = categoriesContentCollectionViewDataSource
        categoriesContentCollectionView.collectionViewLayout = categoriesContentCollectionViewFloawLayout.setupFlowLayout()
        categoriesContentCollectionView.delegate = categriesContentCollectionViewDelegate
        registerCellForCollectionView()
        categoriesContentCollectionViewDataSource.delegate = self
        
        //Handle select row action
        categriesContentCollectionViewDelegate.didSelectRow = { indexPath in
            self.router?.navigate(to: .adCategoriesRoute)
        }
    }

    private func setupNavbar(){
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search for prodduct..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: .barCodeImage), style: .plain, target: self, action: #selector(barCode))
    }
    
    @objc private func barCode(){
        
    }
    
    private func setupViewModel(){
        viewModel = CategoriesViewModel(dataSource: AppDataSource())
        viewModel.delegate = self
        viewModel.getCategries()
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


extension CategoriesViewController: CategoriesViewModelDelegate  {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func loadCategoriesSuccess(category: Category) {
        categoriesTableViewDataSource.category = category
        activityIndicator.stopAnimating()
        categoriesTableView.reloadData()
        categoriesContentCollectionView.reloadData()
    }
    
    
}
