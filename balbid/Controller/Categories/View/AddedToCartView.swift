//
//  AddedToCartView.swift
//  balbid
//
//  Created by Memo Amassi on 10/02/2021.
//

import UIKit

class AddedToCartView: UIView {
    
    var topConstraint : NSLayoutConstraint!
    var isOpen : Bool = false {
        didSet {
            showOrHideView(isOpen: isOpen)
        }
    }
    weak var delegate: AddedToCartViewDelegate?
    

    class func initFromNib() -> AddedToCartView {
        return Bundle.init(for: AddedToCartView.self).loadNibNamed(.addedToCartView, owner: self, options: nil)!.first as! AddedToCartView
    }

    
    // setup the constraint of the view
    func setupView(){
        let screenWidth = UIScreen.main.bounds.width
        let height = 116 + safeAreaInsets.top
        anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , size: CGSize(width: screenWidth , height: height))
        
        topConstraint = topAnchor.constraint(equalTo: superview?.topAnchor ?? topAnchor, constant: -116 - safeAreaInsets.top)
        centerXAnchor.constraint(equalTo: (superview?.centerXAnchor)!).isActive = true
        topConstraint.isActive = true
        withCornerRadius(15, corners: [.bottomLeft,.bottomRight])
    }
    
    
    
    //show view with animation
    func showOrHideView(isOpen: Bool){
        self.topConstraint.constant = isOpen ? 0 : ( -116 - safeAreaInsets.top)
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        UIView.transition(with: window, duration: 1, options: .curveEaseInOut, animations: {
            window.layoutIfNeeded()
        }, completion: nil)
    }

    
    @IBAction func pay(_ sender: Any){
        delegate?.AddedToCartView(self, perform: .pay)
    }
    
    @IBAction func continueShopping(_ sender: Any){
        delegate?.AddedToCartView(self, perform: .continueShopping)
    }
    
    enum ActionType {
        case pay, continueShopping
    }

}


protocol AddedToCartViewDelegate: class {
    func AddedToCartView(_ addedToCartView:  AddedToCartView, perform actionType: AddedToCartView.ActionType)
}
