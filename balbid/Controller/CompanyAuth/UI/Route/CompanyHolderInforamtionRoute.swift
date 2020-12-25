//
//  companyHolderInforamtionRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit

class CompanyHolderInforamtionRoute: Route {
    var modalPresentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }

    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        return nil
    }

    var navigateType: NavigateType {
        return .push

    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController = UIStoryboard.authComapnyStoryboard.getViewController(with: .companyHolderInformationViewControllerId) as! BaseViewController
        viewController.router = router
        return viewController
    }
}
