//
//  OrderPaymentViewController.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit

class OrderPaymentViewController: BaseViewController {
    
    @IBOutlet weak var transactionImageView: BorderedImageView!
    @IBOutlet weak var creditEventView: UIView!
    @IBOutlet weak var bankTransferView: UIView!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var paymentCollectionView: UICollectionView!
    @IBOutlet weak var paymentMethodActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var transactionNumberTextField: BorderedTextField!
    @IBOutlet weak var creditCardHeightEventConstraint: NSLayoutConstraint!
    private let paymentMethodDataSource = PaymentMethodDataSource()
    private let paymentMethodDelegate = PaymentMethodDelegate()
    private let viewModel = OrderPaymentViewModel(dataSource: AppDataSource())
    weak var delegate: SizeChangableDelegate?
    private var imagePickerHelper: ImagePickerHelper?
    private var pickedImage:  Data?
    
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
        setupImagePicker()

    }
    
    private func setupImagePicker() {
        imagePickerHelper = ImagePickerHelper.init(viewController: self, router: router)
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
            case .bankTransfer:
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
    
    @IBAction func uploadImage(_ sender: UIButton) {
        imagePickerHelper?.displayImagePickerAlertActionSheet(with: sender, mustCropImage: true)
        imagePickerHelper?.completion = .some({[weak self] (urls) in
            self?.transactionImageView.isError = false
                self?.transactionImageView.sd_setImage(with: urls[0], completed: {_,_,_,_ in
                    self?.pickedImage = self?.transactionImageView.image?.jpeg(.medium)

                })
        })
    }
    
    func validate() -> (PaymentMethod?, String?, URL?) {
        errorLabel.isHidden = true
        if( paymentMethodDataSource.paymentMethods.isEmpty) {
            return (nil,nil,nil)
        }
        
        let paymentType = PaymentMethodType(rawValue: paymentMethodDataSource.paymentMethods[paymentMethodDataSource.selectedIndex].id)
        if paymentType == .bankTransfer {
            return validateBankTransferPaymentMethod()
        }
        return (paymentMethodDataSource.paymentMethods[paymentMethodDataSource.selectedIndex], nil, nil)
    }
    
    
    func validateBankTransferPaymentMethod() -> (PaymentMethod?, String?, URL?) {
        var isValid = true
        if pickedImage == nil {
            transactionImageView.isError = true
            isValid = false
            errorLabel.text = "Please attach a copy of transaction process"

        }
        if transactionNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  ?? true{
            transactionNumberTextField.isError = true
            errorLabel.text = "Please fill transaction No."
            isValid = false
        }
      
        if(!isValid) {
            errorLabel.isHidden = false
            return (nil,nil,nil)
        }
        return (paymentMethodDataSource.paymentMethods[paymentMethodDataSource.selectedIndex], transactionNumberTextField.text!, pickedImage?.saveImage())
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


