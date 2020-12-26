//
//  companyHolderInforamtionRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit
import AppRouter

class CompanyHolderInforamtionRoute: Route {

    var navigateType: NavigateType {
        .push
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let viewController = UIStoryboard.authComapnyStoryboard.getViewController(with: .companyHolderInformationViewControllerId) as! BaseViewController
        return viewController
    }
}
