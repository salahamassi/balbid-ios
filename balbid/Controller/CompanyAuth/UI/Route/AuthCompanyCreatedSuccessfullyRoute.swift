//
//  AuthCompanyCreatedSuccessfullyRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 24/12/2020.
//

import UIKit
import AppRouter


class AuthCompanyCreatedSuccessfullyRoute: Route {
    var modalPresentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }

    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        return nil
    }

    var navigateType: NavigateType {
        return .windowRoot

    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController = UIStoryboard.authComapnyStoryboard.getViewController(with: .authCompanyCreatedSuccessfullyViewControllerId)
//        viewController.router = router
        return viewController
    }
}
