//
//  OrderPaymentViewController.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit

class OrderPaymentViewController: BaseViewController {

    @IBOutlet weak var creditEventView: UIView!
    @IBOutlet weak var bankTransferView: UIView!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var paymentCollectionView: UICollectionView!
    @IBOutlet weak var paymentMethodActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var creditCardHeightEventConstraint: NSLayoutConstraint!
    private let paymentMethodDataSource = PaymentMethodDataSource()
    private let paymentMethodDelegate = PaymentMethodDelegate()
    private let viewModel = OrderPaymentViewModel(dataSource: AppDataSource())
    weak var delegate: SizeChangableDelegate?
    
    lazy var  creditEventViewController: CreditEventViewController = {
        let viewController = UIStoryboard.createOrderStoryboard.getViewController(with: .creditEventViewController)as! CreditEventViewController
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    private func setupView() {
        setupPaymentMethodCollectionView()
        self.add(self.creditEventViewController, to: self.creditEventView, frame: self.creditEventView.frame)
        creditCardHeightEventConstraint.constant = (self.creditEventViewController.view.subviews.first?.frame.height ?? .zero) + 20

    }
    
    private func setupPaymentMethodCollectionView() {
        paymentCollectionView.dataSource = paymentMethodDataSource
        paymentCollectionView.delegate = paymentMethodDelegate
        paymentMethodDelegate.didSelectRow = { [weak self] position in
            guard let self = self else {
                return
            }
            self.setupPaymentMethodView(position: position)
            self.paymentMethodDataSource.selectedIndex = position
            self.paymentCollectionView.reloadData()
        }
    }
    
    private func setupPaymentMethodView(position: Int) {
        let paymentMethodType = PaymentMethodType(rawValue: paymentMethodDataSource.paymentMethods[position].id)
        cashView.isHidden = true
        creditEventView.isHidden = true
        bankTransferView.isHidden = true
        switch paymentMethodType {
            case .cashMethod:
                cashView.isHidden = false
            case .bankTrannsfer:
                bankTransferView.isHidden = false
            case .creditEvent:
                creditEventView.isHidden = false
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.didUpdateContentSize(newHeight: (self.view.subviews.first?.frame.height ?? .zero) + 20)

        }
    }

    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getPaymentMethod()
    }
    
    func validate() -> PaymentMethod {
        return paymentMethodDataSource.paymentMethods[paymentMethodDataSource.selectedIndex]
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


enum PaymentMethodType: Int {
    case cashMethod = 1
    case creditEvent = 2
    case bankTrannsfer = 3

}
