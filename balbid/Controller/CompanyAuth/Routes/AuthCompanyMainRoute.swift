//
//  AuthCompanyMainRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit
import AppRouter

class AuthCompanyMainRoute: Route {

    var navigateType: NavigateType {
        .push
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController = UIStoryboard.authComapnyStoryboard.getViewController(with: .authComapnyMainViewControllerId) as!  BaseViewController
        return viewController
    }
}
