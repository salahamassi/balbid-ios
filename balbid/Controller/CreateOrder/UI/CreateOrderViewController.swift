//
//  CreateOrderViewController.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit

class CreateOrderViewController: BaseViewController {
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstant: NSLayoutConstraint!
    
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
            currentViewController = shippingAddressViewController
        case 2:
            currentViewController = orderPaymentViewController
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
            step += 1
            setNavTitle()
            setContainerView()
        } else if step == 3 {
            
        }
    }
    
}


extension CreateOrderViewController: SizeChangableDelegate {
    func didUpdateContentSize(newHeight: CGFloat) {
        containerViewHeightConstant.constant = newHeight 
    }
    
    
}
