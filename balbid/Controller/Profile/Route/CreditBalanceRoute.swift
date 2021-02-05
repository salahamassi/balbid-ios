//
//  CreditBalanceRoute.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit
import AppRouter

class CreditBalanceRoute: Route {
    var navigateType: NavigateType {
        return .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.profileStoryboard.getViewController(with: .creditBalanceViewController)
        return viewController
    }

    
}
