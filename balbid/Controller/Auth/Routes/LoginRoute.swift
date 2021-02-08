//
//  LoginRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class LoginRoute: Route {
    var modalPresentationStyle: UIModalPresentationStyle {
        return  .fullScreen
    }

    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        return nil
    }

    var navigateType: NavigateType {
        return .push

    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let dataSource = AppDataSource()
        let viewController = UIStoryboard.authStoryboard.getViewController(with: .loginViewControllerId) as! LoginViewController
        let loginViewModel = LoginViewModel(source: dataSource)
        loginViewModel.delegate = viewController
        viewController.validate = loginViewModel.validate
        return viewController
    }
}
