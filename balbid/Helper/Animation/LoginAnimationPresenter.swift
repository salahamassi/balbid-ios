//
//  ZoomAnimationPresenter.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit

class LoginAnimationPresenter: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? SplashViewController,
            let fromSplashImageView = fromViewController.splashLogoImageView,
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to),
            let toViewController = (transitionContext.viewController(forKey: .to) as? UINavigationController)?.topViewController as? LoginOptionViewController,
            let toSplashImageView = toViewController.splashLogoImageView,
            let toSplashImageViewFrame = toSplashImageView.superview?.convert(toSplashImageView.frame, to: fromView),
            let fromSplashImageViewFrame = fromSplashImageView.superview?.convert(fromSplashImageView.frame, to: toView)
        else { return }
        let oldWidth = toSplashImageViewFrame.size.width
        toSplashImageView.transform = CGAffineTransform(scaleX: 1.9, y: 1.9)
            .translatedBy(x: 0, y: (fromSplashImageViewFrame.minY - toSplashImageViewFrame.minY) - (oldWidth/2))
        toViewController.loginButton.alpha = 0
        toViewController.createAccountButton.alpha = 0
        toViewController.continueAsguestButton.alpha = 0
        toViewController.loginButton.alpha = 0

        containerView.addSubview(toView)
        UIView.animate(withDuration: 1.5) {
            toSplashImageView.transform = .identity
        } completion: { (succes) in
            transitionContext.completeTransition(succes)
        }
        
        UIView.animate(withDuration: 1.2, delay: 0.3) {
            toViewController.createAccountButton.alpha = 1
            toViewController.continueAsguestButton.alpha = 1
            toViewController.loginButton.alpha = 1
        } completion: { (_) in
            
        }

    }
}
