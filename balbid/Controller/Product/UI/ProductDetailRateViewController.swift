//
//  ProductDetailRateViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class ProductDetailRateViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let rateTableViewDataSource: RateTableViewDataSource = RateTableViewDataSource()
    let rateTableViewDelegate: RateTableViewDelegate = RateTableViewDelegate()
    private var ViewModel: ProductDetailRateViewModel!
    var productId : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView(){
        tableView.delegate = rateTableViewDelegate
        tableView.dataSource = rateTableViewDataSource
    }
    
    private func setupViewModel() {
        ViewModel = ProductDetailRateViewModel(dataSource: AppDataSource())
        ViewModel.delegate = self
        ViewModel.getProductEvaluation(id: 1963)
    }

}


extension ProductDetailRateViewController: ProductDetailRateViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didLoadEvalutionSuccess(evaluation: EvaluationItem) {
        activityIndicator.stopAnimating()
        rateTableViewDataSource.evaluation = evaluation
        tableView.reloadData()
    }
    
    
}
