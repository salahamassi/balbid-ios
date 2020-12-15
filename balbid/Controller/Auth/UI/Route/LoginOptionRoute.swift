//
//  LoginRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit

class LoginOptionRoute: Route {
    var modalPresentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }
    
    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        return nil
    }
    
    var navigateType: NavigateType {
        .present
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.authStoryboard.getViewController(with: .loginOptionViewControllerId)
        return viewController
    }
}

