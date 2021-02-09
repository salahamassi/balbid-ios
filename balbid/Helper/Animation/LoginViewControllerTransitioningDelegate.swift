//
//  LoginViewControllerTransitioningDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 09/02/2021.
//

import UIKit

class LoginViewControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LoginAnimationPresenter()
      }
      
      func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        nil
      }
}
