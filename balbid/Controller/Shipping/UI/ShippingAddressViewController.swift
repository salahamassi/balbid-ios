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
    
    weak var delegate: SizeChangableDelegate?

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
        (navigationController as? AppNavigationController)?.restyleBackButton()
    }
    
    private func setupTableView(){
        tableView.dataSource = shippingAdressTableViewDataSource
        tableView.delegate = shippingAddressTableViewDelegate
        shippingAddressTableViewDelegate.didSelect = { indexPath in
            self.shippingAdressTableViewDataSource.selectedIndex = indexPath.row
            self.tableView.reloadData()
            guard let id =  self.shippingAdressTableViewDataSource.address?.addresses[indexPath.row].id else {
                return
            }
            UserDefaultsManager.selectedAddressId = id
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
    
    func validate() -> Bool {
        if shippingAdressTableViewDataSource.selectedIndex == -1 {
            displayAlert(message: "Please select shipping Address")
            return false
        }
        return true
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
        let id = UserDefaultsManager.selectedAddressId
        shippingAdressTableViewDataSource.selectedIndex = address.addresses.firstIndex(where: { (address) -> Bool in
            address.id ==  id
        }) ?? -1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.didUpdateContentSize(newHeight: (self.view.subviews.first?.frame.height ?? .zero) + 20)
        }
    }
}
