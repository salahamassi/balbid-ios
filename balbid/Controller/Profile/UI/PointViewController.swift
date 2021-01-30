//
//  PointViewController.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class PointViewController: BaseViewController {
    
    @IBOutlet weak var pointTableView: UITableView!
    @IBOutlet weak var replacementPointLabel: UILabel!

    private let pointTableViewDataSource = PointTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTableView()
        setupView()
    }

    private func setupNavbar(){
        self.title = "Points"
        (self.navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupTableView(){
        pointTableView.dataSource = pointTableViewDataSource
    }

    private func setupView(){
        let mainText =
        "New Point ".convertToMutableAttributedString(with: UIFont.medium.withSize(12), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  "1220".components(separatedBy: ":")[0].convertToAttributedString(with: UIFont.medium.withSize(20), and: #colorLiteral(red: 0.1176470588, green: 0.137254902, blue: 0.3215686275, alpha: 1))
        mainText.append(secondaryText)
        replacementPointLabel.attributedText = mainText
    }
    
}
