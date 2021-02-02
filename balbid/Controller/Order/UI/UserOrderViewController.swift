//
//  UserOrderViewController.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class UserOrderViewController: BaseViewController {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var orderTableView: UITableView!

    
    private var filterCollectionViewDataSource: FilterCollectionViewDataSource!
    private var filterCollectionViewDelegate: FilterCollectionViewDelegate!
    var filters = ["All","Pending","Delivered","Cancelled","Returned"]
    var selectedIndexPath: [IndexPath] = []
    
    private var orderTableViewDataSource = OrderTableViewDataSource()
    private var orderTableViewDelegate = OrderTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupFilterCollectionView()
        setupOrderTableView()
    }
    
    private func setupNavbar(){
        self.title = "Orders"
        (self.navigationController as! AppNavigationController).restyleBackButton()
    }
    

    private func setupFilterCollectionView(){
        filterCollectionViewDelegate = FilterCollectionViewDelegate(filters: filters)
        filterCollectionViewDelegate.didSelectItem = { [self] indexPath in
            if(!self.filterCollectionViewDataSource.selectedIndexPath.contains(indexPath)){
                self.filterCollectionViewDataSource.selectedIndexPath.append(indexPath)
            }else{
                self.filterCollectionViewDataSource.selectedIndexPath.remove(at: self.filterCollectionViewDataSource .selectedIndexPath.firstIndex(of: indexPath) ?? 0)
            }
            self.filterCollectionView.reloadItems(at: [indexPath])
        }
        filterCollectionViewDataSource = FilterCollectionViewDataSource(filters: filters)
        filterCollectionView.dataSource = filterCollectionViewDataSource
        filterCollectionView.delegate = filterCollectionViewDelegate
    }
    
    private func setupOrderTableView(){
        orderTableView.dataSource = orderTableViewDataSource
        orderTableView.delegate = orderTableViewDelegate
        orderTableViewDelegate.didSelectRow = { indexPath in
            self.router?.navigate(to: .orderDetailRoute)
        }
    }
    
  

}
