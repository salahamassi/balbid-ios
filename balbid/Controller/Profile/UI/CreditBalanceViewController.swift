//
//  CreditBalanceViewController.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class CreditBalanceViewController: BaseViewController {
    
    @IBOutlet weak var creditBalanceView: UIView!
    @IBOutlet weak var consumedLabel: UILabel!
    @IBOutlet weak var creditBalanceTableView: UITableView!
    
    private let creditBalanceTableViewDataSource = CreditBalanceTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupConsumedTextLabel()
        setupTableView()
    }
    
    private func setupNavbar() {
        title = "Credit Balance"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupTableView(){
        creditBalanceTableView.dataSource = creditBalanceTableViewDataSource
    }

    private func setupConsumedTextLabel() {
        let mainText =
            "Been Consumed ".convertToMutableAttributedString(with: UIFont.medium.withSize(14), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  "10.000 SR".convertToAttributedString(with: UIFont.medium.withSize(14), and: #colorLiteral(red: 0.8823529412, green: 0.431372549, blue: 0.03921568627, alpha: 1))
        mainText.append(secondaryText)
        consumedLabel.attributedText = mainText
    }
}
