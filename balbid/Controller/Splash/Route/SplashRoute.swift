//
//  SplashRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit
import AppRouter

struct SplashRoute: Route {

    var navigateType: NavigateType {
        .windowRoot
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController =  UIStoryboard.splashStoryboard.getViewController(with: .splashViewControllerId)  as!  BaseViewController
        return viewController
    }
}
