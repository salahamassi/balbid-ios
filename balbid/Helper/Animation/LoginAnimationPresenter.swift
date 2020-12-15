//
//  ZoomAnimationPresenter.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit

class LoginAnimationPresenter: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        let splashViewController = fromViewController as! SplashViewController
//        splashViewController.splashLogoImageView
        
        
    }
    
    
}
