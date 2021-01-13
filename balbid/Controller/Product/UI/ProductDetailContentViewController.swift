//
//  ProductDetailContentViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class ProductDetailContentViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quickReadButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!

    @IBOutlet weak var tabIndicatorConstraint: NSLayoutConstraint!
    
    var currentViewController: UIViewController?
    
    lazy var productDetailQuickViewViewController : ProductDetailQuickViewViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailQuickViewViewController) as! ProductDetailQuickViewViewController
        return viewController
    }()
    
    lazy var productDetailRateViewController : ProductDetailRateViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailRateViewController) as! ProductDetailRateViewController
        return viewController
    }()

    
    @IBOutlet weak var tabIndicatorView: UIView!
    
    weak var delegate: ScrollViewContainingDelegate?

    
   override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewQuickLook(self)
    }
    
  

    private func setupScrollView(){
        scrollView.delegate = self
    }
    

    @IBAction func viewQuickLook(_ sender: Any) {
        changeCurrentContentView(viewController: productDetailQuickViewViewController, activateButton: quickReadButton, unactivedButton: rateButton, tabIndicatorConstraint: 0)

    }
    

    @IBAction func viewRate(_ sender: Any) {
        changeCurrentContentView(viewController: productDetailRateViewController, activateButton: rateButton, unactivedButton: quickReadButton, tabIndicatorConstraint: self.rateButton.frame.width/2 + 62.0 + self.quickReadButton.frame.width/2)
    }
    
    
    func changeCurrentContentView(viewController: UIViewController,activateButton: UIButton, unactivedButton: UIButton,tabIndicatorConstraint: CGFloat){
        currentViewController?.remove()
        add(viewController, to: contentView, frame: contentView.frame)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.contentViewHeight?.constant = (viewController.view.subviews.first?.frame.height ?? .zero) + 32.0
        }
      
        unactivedButton.setTitleColor(UIColor.appColor(.borderGrayColor2), for: .normal)
        activateButton.setTitleColor(UIColor.appColor(.primaryColor), for: .normal)
        currentViewController = viewController
        UIView.animate(withDuration: 0.2) {
            self.tabIndicatorConstraint.constant = tabIndicatorConstraint
        }
    }
}
extension ProductDetailContentViewController: UIScrollViewDelegate {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // pass scroll events to the containing controller
        delegate?.scrollView(didScroll:scrollView)
    }
}
