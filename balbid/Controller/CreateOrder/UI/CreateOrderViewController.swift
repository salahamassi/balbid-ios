//
//  CreateOrderViewController.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit

class CreateOrderViewController: BaseViewController {
    
    @IBOutlet weak var shippingStepImageView: UIImageView!
    @IBOutlet weak var shippingSeperatorView: UIView!
    @IBOutlet weak var shippingStepView: UIView!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var paymentStepImageView: UIImageView!
    @IBOutlet weak var paymentStepView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
  

    var step = 1
    var selectedShippingAddress: AddressItem?
    var selectedPaymentMethod: PaymentMethod?
    var cart: Cart?
    var addNewOrder: ((_ addressId: Int,_  paymentMethodId: Int) -> Void)?

    var currentViewController: UIViewController!
    private var shippingAddressViewModel = ShippingAddressViewModel(dataSource: AppDataSource())
    
    lazy var  shippingAddressViewController: ShippingAddressViewController = {
        let viewController = UIStoryboard.shippingStoryboard.getViewController(with: .orderShippingAddressViewController)as! ShippingAddressViewController
        shippingAddressViewModel.delegate = viewController
        viewController.getUserAddresses = shippingAddressViewModel.getUserAddresses
        viewController.delegate = self
        return viewController
    }()
    
    lazy var orderPaymentViewController: OrderPaymentViewController = {
        let viewController = UIStoryboard.createOrderStoryboard.getViewController(with: .orderPaymentViewController)as! OrderPaymentViewController
        viewController.delegate = self
        return viewController
    }()
    
    
    lazy var createOrderSummaryViewController: CreateOrderSummaryViewController = {
        let viewController = UIStoryboard.createOrderStoryboard.getViewController(with: .createOrderSummaryViewController)as! CreateOrderSummaryViewController
        viewController.delegate = self
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setContainerView()
    }
    
    private func setupView(){
        cartImageView.image = cartImageView.image?.withRenderingMode(.alwaysTemplate)
        addNavleftView()
    }
    
    func setContainerView() {
        currentViewController?.remove()
        switch step {
        case 1:
            setupFirstView()
            currentViewController = shippingAddressViewController
        case 2:
            setupShippingViewStep()
            currentViewController = orderPaymentViewController
        case 3:
            setupPaymentView()
            guard let shippingAdress = selectedShippingAddress,
                  let paymentMethod = selectedPaymentMethod,
                  let cart = cart else {
                break
            }
            createOrderSummaryViewController.shippingAdress = shippingAdress
            createOrderSummaryViewController.paymentMethod = paymentMethod
            createOrderSummaryViewController.cart = cart
            currentViewController = createOrderSummaryViewController
        default:
            break
        }
        
        self.containerViewHeightConstant?.constant = (self.currentViewController.view.subviews.first?.frame.height ?? .zero) + 20
        self.add(self.currentViewController, to: self.containerView, frame: self.containerView.frame)
      
        
    }
    
    func addNavleftView() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: .backImage), style: .plain, target: self, action: #selector(self.goBack))
    }
    
    private func setupShippingViewStep() {
        shippingStepImageView.tintColor = UIColor.appColor(.whiteColor)
        shippingStepView.withBackgroundColor(UIColor.appColor(.primaryColor) ?? .white)
        shippingSeperatorView.withBackgroundColor(UIColor.appColor(.primaryColor) ?? .white)
        paymentStepView.withBackgroundColor(UIColor.appColor(.whiteColor) ?? .white)
        paymentStepImageView.tintColor = UIColor.appColor(.primaryColor)
        backButton.isHidden = false
        continueButton.setTitle("Continue", for: .normal)
    }
    
    private func setupPaymentView() {
        paymentStepView.withBackgroundColor(UIColor.appColor(.primaryColor) ?? .white)
        paymentStepImageView.tintColor = UIColor.appColor(.whiteColor)
        backButton.isHidden = true
        continueButton.setTitle("Confirm Order", for: .normal)
    }
    
    
    private func setupFirstView() {
        shippingStepImageView.tintColor = UIColor.appColor(.primaryColor)
        shippingStepView.withBackgroundColor(UIColor.appColor(.whiteColor) ?? .white)
        shippingSeperatorView.withBackgroundColor(UIColor.appColor(.whiteColor) ?? .white)
    }
    
    @objc func goBack() {
        if  step > 1 {
            step -= 1
            setContainerView()
            setNavTitle()
        } else {
            router?.pop(numberOfScreens: 1)
        }
    }
    
    private func setNavTitle() {
        switch step {
        case 1:
            self.title =  "Shipping  Address"
        case 2:
            self.title =  "Payment Method"
        case 3:
            self.title =  "Confirm Order"
        default:
            break
        }
    }
    
    @IBAction func goToNextStep(_ sender: Any) {
        if  step < 3 {
            validate()
        } else if step == 3 {
            guard let shippingId = selectedShippingAddress?.id,
                  let paymentMethodId = selectedPaymentMethod?.id else {
                return
            }
            continueButton.loadingIndicator(true)
            addNewOrder?(shippingId, paymentMethodId)
        }
    }
    
    private func validate() {
        switch step  {
        case 1:
            let shippingAddress = shippingAddressViewController.validate()
            if shippingAddress != nil {
                selectedShippingAddress = shippingAddress
                moveToNext()
            }
        case 2:
            let paymentMethod = orderPaymentViewController.validate()
            if paymentMethod != nil {
                selectedPaymentMethod = paymentMethod
                moveToNext()
            }
        default:
            break
        }
    }
    
    private func moveToNext(){
        step += 1
        setNavTitle()
        setContainerView()
    }
    
}


extension CreateOrderViewController: SizeChangableDelegate {
    func didUpdateContentSize(newHeight: CGFloat) {
        containerViewHeightConstant.constant = newHeight 
    }
    
    
}

extension CreateOrderViewController: CreateOrderViewModelDelegate {
    func apiError(error: String) {
        continueButton.loadingIndicator(false)
        displayAlert(message: error)
    }
    
    func didAddOrderSuccess() {
        continueButton.loadingIndicator(false)
        router?.navigate(to: .orderCreatedSuccessfullyRoute)

    }
    
    
}
