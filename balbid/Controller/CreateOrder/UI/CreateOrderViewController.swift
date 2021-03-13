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
    var step = 1
    
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
            currentViewController = createOrderSummaryViewController
        default:
            break
        }
        self.containerViewHeightConstant?.constant = (self.currentViewController.view.subviews.first?.frame.height ?? .zero) + 20
        print(self.currentViewController.view.subviews.first?.frame.height ?? .zero)
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
    }
    
    private func setupPaymentView() {
        paymentStepView.withBackgroundColor(UIColor.appColor(.primaryColor) ?? .white)
        paymentStepImageView.tintColor = UIColor.appColor(.whiteColor)
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
            
        }
    }
    
    func validate() {
        switch step  {
        case 1:
            if shippingAddressViewController.validate() {
                step += 1
                setNavTitle()
                setContainerView()
            }
        default:
            break
        }
    }
    
}


extension CreateOrderViewController: SizeChangableDelegate {
    func didUpdateContentSize(newHeight: CGFloat) {
        containerViewHeightConstant.constant = newHeight 
    }
    
    
}
