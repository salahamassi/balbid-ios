//
//  OrderPaymentViewController.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit

class OrderPaymentViewController: BaseViewController {

    @IBOutlet weak var paymentCollectionView: UICollectionView!
    @IBOutlet weak var paymentMethodActivityIndicator: UIActivityIndicatorView!
    
    private let  paymentMethodDataSource = PaymentMethodDataSource()
    private let viewModel = OrderPaymentViewModel(dataSource: AppDataSource())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    private func setupView() {
        setupPaymentMethodCollectionView()
    }
    
    private func setupPaymentMethodCollectionView() {
        paymentCollectionView.dataSource = paymentMethodDataSource
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getPaymentMethod()
    }

}

extension  OrderPaymentViewController: OrderPaymentViewModelDelegate{
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didLoadPaymentMethodSuccess(paymentMethods: [PaymentMethod]) {
        paymentMethodActivityIndicator.stopAnimating()
        paymentMethodDataSource.paymentMethods = paymentMethods
        paymentCollectionView.reloadData()
    }
    
    
}
