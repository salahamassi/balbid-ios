//
//  ShippingAdressViewController.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ShippingAdressViewController: BaseViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!

    private var shippingAdressTableViewDataSource = ShippingAdressTableViewDataSource()
    private var shippingAddressTableViewDelegate = ShippingAddressTableViewDelegate()
    private var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTableView()
        setupView()
    }
    
    private func setupNav(){
        title = "Shipping addresses"
        (navigationController as? AppNavigationController)?.restyleBackButton()
    }
    
    private func setupTableView(){
        tableView.dataSource = shippingAdressTableViewDataSource
        tableView.delegate = shippingAddressTableViewDelegate
        shippingAddressTableViewDelegate.didSelect = { [weak self] indexPath in
            self?.shippingAdressTableViewDataSource.selectedIndex = indexPath.row
            self?.tableView.reloadData()
        }
    }
    
    private func setupView(){
        addButton.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate), for: .highlighted)

        addButton.tintColor = .white
    }
  
    
    @IBAction func showAddNewAddressView(){
        router?.navigate(to: .addNewShippingRoute)
    }

}
