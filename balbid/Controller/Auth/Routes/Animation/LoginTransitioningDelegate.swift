//
//  LoginAnimatedTransitioning.swift
//  balbid
//
//  Created by Memo Amassi on 09/02/2021.
//

import UIKit

class LoginTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return LoginAnimationPresenter()
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return nil
        }
}
