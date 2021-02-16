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
    private let categoriesTableViewDelegate = CategoriesTableViewDelegate()
    private let categoriesContentCollectionViewDataSource = CategoriesContentCollectionViewDataSource()
    private let categoriesContentCollectionViewFloawLayout = CategriesContentCollectionViewFlowLayout()
    private let categriesContentCollectionViewDelegate = CategriesContentCollectionViewDelegate()

    private let searchBar = UISearchBar(frame: .zero)
    
    
    private var viewModel: CategoriesViewModel!
    private var category: Category?
    private var lastSelectedMainCategoryIndex: Int = 0

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
        categoriesTableView.delegate = categoriesTableViewDelegate
        categoriesTableViewDelegate.didSelect = { [weak self]  indexPath in
            self?.lastSelectedMainCategoryIndex = indexPath.row
            self?.categoriesContentCollectionViewDataSource.isExpanded.removeAll()
            self?.categoriesContentCollectionViewDataSource.categoriesItem  = self?.category?.categoryItems[indexPath.row].children ?? []
            self?.categoriesContentCollectionView.reloadData()
        }
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
        categriesContentCollectionViewDelegate.didSelectRow = { [weak self] indexPath in
            guard let category = self?.category?.categoryItems[self?.lastSelectedMainCategoryIndex ?? 0].children[indexPath.section].children[indexPath.row] else {
                return
            }
            self?.router?.navigate(to: CategoriesRoutes.adCategoriesRoute(params: ["category": category]))
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
    
        for i in 0..<(category?.categoryItems[lastSelectedMainCategoryIndex].children[section].children.count ?? 0) {
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
        self.category = category
        categoriesTableViewDataSource.category = category
        if(category.categoryItems.count > 0){
            categoriesContentCollectionViewDataSource.categoriesItem = category.categoryItems[0].children
        }
        activityIndicator.stopAnimating()
        categoriesTableView.reloadData()
        categoriesContentCollectionView.reloadData()
    }
    
    
}
