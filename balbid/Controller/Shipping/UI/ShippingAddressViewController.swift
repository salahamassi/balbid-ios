//
//  ShippingAdressViewController.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ShippingAddressViewController: BaseViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var shippingAdressTableViewDataSource = ShippingAddressTableViewDataSource()
    private var shippingAddressTableViewDelegate = ShippingAddressTableViewDelegate()
    private var selectedIndex = -1
    
    var  getUserAddresses: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTableView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserAddresses?()
    }
    
    private func setupNav(){
        title = "Shipping addresses"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupTableView(){
        tableView.dataSource = shippingAdressTableViewDataSource
        tableView.delegate = shippingAddressTableViewDelegate
        shippingAddressTableViewDelegate.didSelect = { indexPath in
            self.shippingAdressTableViewDataSource.selectedIndex = indexPath.row
            self.tableView.reloadData()
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

extension ShippingAddressViewController: ShippingAddressViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didLoadAddressSuccess(address: Address) {
        shippingAdressTableViewDataSource.address = address
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
}
