//
//  MainTabBarRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 25/12/2020.
//

import UIKit
import AppRouter

class MainTabBarRoute: Route {

    var transition: CATransition? {
        .fadeTransition
    }
    
    var navigateType: NavigateType {
        .windowRoot
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController = UIStoryboard.mainStoryboard.getViewController(with: .mainTabBarViewControllerId)
        return viewController
    }
}
