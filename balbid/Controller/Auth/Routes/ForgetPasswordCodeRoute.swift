//
//  ForgetPasswordCodeRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class ForgetPasswordCodeRoute: Route {

    var navigateType: NavigateType {
        .push
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController = UIStoryboard.authStoryboard.getViewController(with: .forgetPasswordCodeViewControllerId) as!  BaseViewController
        return viewController
    }
}
