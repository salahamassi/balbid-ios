//
//  ShowCartDelegate.swift
//  balbid
//
//  Created by Apple on 19/02/2021.
//

import UIKit

class ItemAddedToCartDelegate: NSObject, AddedToCartViewDelegate {
    
    var  continueShopping: (()  -> Void)?
    var  popController: (()  -> Void)?

    func AddedToCartView(_ addedToCartView: AddedToCartView, perform actionType: AddedToCartView.ActionType) {
        switch actionType {
        case .continueShopping:
            addedToCartView.showOrHideView(isOpen: false)
            continueShopping?()
        case .pay:
            addedToCartView.showOrHideView(isOpen: false)
            popController?()
            guard let tabBarController = ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? UITabBarController) else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                tabBarController.selectedIndex = 3
            }
        
        }
    }
}
