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
    
    lazy var  shippingAddressViewController: ShippingAdressViewController = {
        let viewController = UIStoryboard.shippingStoryboard.getViewController(with: .OrderShippingAdressViewController)as! ShippingAdressViewController
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setContainerView()
    }
    
    private func setupView(){
        cartImageView.image = cartImageView.image?.withRenderingMode(.alwaysTemplate)
    }
    
    func setContainerView() {
        currentViewController?.remove()
        switch step {
        case 1:
            currentViewController = shippingAddressViewController
        default:
            currentViewController = shippingAddressViewController

        }
        add(currentViewController, to: containerView, frame: containerView.frame)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.containerViewHeightConstant?.constant = self.currentViewController.view.subviews.first?.frame.height ?? .zero
            print(self.currentViewController.view.subviews.first?.frame.height ?? .zero)

        }
     
    }
    
    
    
}
