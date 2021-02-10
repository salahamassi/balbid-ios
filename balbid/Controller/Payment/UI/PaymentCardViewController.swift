//
//  PaymentCardViewController.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class PaymentCardViewController: BaseViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var paymentCardTableViewDataSource = PaymentCardTableViewDataSource()
    private var paymentCardTableViewDelegate = PaymentCardTableViewDelegate()
    private var addNewCardBottomSheet: AddNewCardBottomSheet!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTableView ()
        setupAddButtonView()
        setupAddNewCardBottomSheet()
    }
    
    private func setupNavbar(){
        self.title = "Pay"
        (self.navigationController as! AppNavigationController).restyleBackButton()
    }
    
    
    private func setupTableView(){
        tableView.dataSource = paymentCardTableViewDataSource
        tableView.delegate = paymentCardTableViewDelegate
        paymentCardTableViewDelegate.didSelectRow =  { [weak self] indexPath in
            guard let preSelectedIndex = self?.paymentCardTableViewDataSource.selectedIndex else {
                return
            }
            self?.paymentCardTableViewDataSource.selectedIndex = indexPath.row
            self?.tableView.reloadRows(at: preSelectedIndex != -1 ? [IndexPath(row: preSelectedIndex, section: 0),IndexPath(row: indexPath.row, section: 0)] : [IndexPath(row: indexPath.row, section: 0)] , with: .none)
        }

    }
    
    private func setupAddButtonView(){
        addButton.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate), for: .highlighted)

        addButton.tintColor = .white
    }
    
    private func setupAddNewCardBottomSheet(){
        addNewCardBottomSheet = AddNewCardBottomSheet.initFromNib()
    }
    
    @IBAction func addNewCard(_ sender: Any){
        addNewCardBottomSheet.show()
    }

}
