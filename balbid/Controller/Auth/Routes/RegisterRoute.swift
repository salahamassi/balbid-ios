//
//  RegisterRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class RegisterRoute: Route {
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
        

        let viewController = UIStoryboard.authStoryboard.getViewController(with: .registerViewControllerId) as! RegisterViewController
        let presneter = RegisterViewPresenter<RegisterViewController>()
        presneter.output = viewController
        let registerViewModel = RegisterViewModel(dataSource: AppDataSource(), output: presneter)
        viewController.validate = registerViewModel.validate
        
        return viewController
    }
}

