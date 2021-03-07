//
//  LoginRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit
import AppRouter

class LoginOptionRoute: Route {
    
    let transitioningDelegate: LoginTransitioningDelegate?
    init(transitioningDelegate: LoginTransitioningDelegate?) {
        self.transitioningDelegate = transitioningDelegate
    }

    var modalPresentationStyle: UIModalPresentationStyle {
        .fullScreen
    }

    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        transitioningDelegate
    }
    
    var navigateType: NavigateType {
        .present
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let navigationController = UIStoryboard.authStoryboard.getViewController(with: .loginNavigationViewControllerId) as! AppNavigationController
        return navigationController
    }
}

