//
//  AccountOptionRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit
import AppRouter

class  AccountOptionRoute: Route {
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
        let viewController = UIStoryboard.authStoryboard.getViewController(with: .accountOptionViewControllerId) as! BaseViewController
        return viewController
    }

}
