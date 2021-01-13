//
//  ProductDetailRateViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class ProductDetailRateViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let rateTableViewDataSource: RateTableViewDataSource = RateTableViewDataSource()
    let rateTableViewDelegate: RateTableViewDelegate = RateTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()


    }
    

    private func setupTableView(){
        tableView.delegate = rateTableViewDelegate
        tableView.dataSource = rateTableViewDataSource

    }

}
