//
//  ProductDetailRateViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit
import Cosmos
class ProductDetailRateViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var averageRating: CosmosView!
    @IBOutlet weak var firstRating: UIProgressView!
    @IBOutlet weak var secondRating: UIProgressView!
    @IBOutlet weak var thirdRating: UIProgressView!
    @IBOutlet weak var fourthRating: UIProgressView!
    @IBOutlet weak var fifthRating: UIProgressView!
    private let rateTableViewDataSource: RateTableViewDataSource = RateTableViewDataSource()
    private let rateTableViewDelegate: RateTableViewDelegate = RateTableViewDelegate()
    private var viewModel: ProductDetailRateViewModel!
    var productId : Int!
    
    @IBOutlet weak var firstCountStar: UILabel!
    @IBOutlet weak var secondtCountStar: UILabel!
    @IBOutlet weak var thirdCountStar: UILabel!
    @IBOutlet weak var fouthCountStar: UILabel!
    @IBOutlet weak var fifthCountStar: UILabel!
    
    @IBOutlet weak var commentNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView(){
        tableView.delegate = rateTableViewDelegate
        tableView.dataSource = rateTableViewDataSource
        rateTableViewDelegate.delegate = self
    }
    
    private func setupViewModel() {
        viewModel = ProductDetailRateViewModel(dataSource: AppDataSource())
        viewModel.delegate = self
        viewModel.getProductEvaluation(id: 1963)
    }

}


extension ProductDetailRateViewController: ProductDetailRateViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didLoadEvalutionSuccess(evaluation: EvaluationItem) {
        activityIndicator.stopAnimating()
        setData(evaluation: evaluation)
        rateTableViewDataSource.evaluation = evaluation
        tableView.reloadData()
    }
    
    private func setData(evaluation: EvaluationItem) {
        averageRatingLabel.text
            = "\(viewModel.avgRate())"
        averageRating.rating = viewModel.avgRate()
        firstRating.progress = viewModel.firstRateValue()
        secondRating.progress = viewModel.secondRateValue()
        thirdRating.progress = viewModel.thirdRateValue()
        fourthRating.progress = viewModel.fourthRateValue()
        fifthRating.progress = viewModel.fifthRateValue()
        
        firstCountStar.text = "( " + evaluation.rating1 + " )"
        secondtCountStar.text = "( " + evaluation.rating2 + " )"
        thirdCountStar.text = "( " + evaluation.rating3 + " )"
        fouthCountStar.text =  "( " + evaluation.rating4 + " )"
        fifthCountStar.text = "( " + evaluation.rating5 + " )"
        
        commentNumberLabel.text = "\(evaluation.comments.count) Comments"
        rateTableViewDelegate.shouldShowFooter = evaluation.comments.count >= 5
    }
    
    
}

extension ProductDetailRateViewController: EvaluationFooterCellDelegate {
    func loadMore(_ evaluationFooterCell: EvaluationFooterCell) {
        print("Hi Evaluation cellr" )
        
    }
}
