//
//  PaymentCardViewController.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class PaymentCardViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var paymentCardTableViewDataSource = PaymentCardTableViewDataSource()
    private var paymentCardTableViewDelegate = PaymentCardTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
    }
    
    private func setupNavbar(){
        self.title = "Pay"
        (self.navigationController as! AppNavigationController).restyleBackButton()
    }
    
    
    private func setupView(){
        tableView.dataSource = paymentCardTableViewDataSource
        tableView.delegate = paymentCardTableViewDelegate
        paymentCardTableViewDelegate.didSelectRow =  { indexPath in
            let preSelectedIndex = self.paymentCardTableViewDataSource.selectedIndex
            self.paymentCardTableViewDataSource.selectedIndex = indexPath.row
            self.tableView.reloadRows(at: preSelectedIndex != -1 ? [IndexPath(row: preSelectedIndex, section: 0),IndexPath(row: indexPath.row, section: 0)] : [IndexPath(row: indexPath.row, section: 0)] , with: .none)
        }

    }

}
