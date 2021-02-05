//
//  PaymentCardRoute.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit
import AppRouter

class PaymentCardRoute: Route {
    var navigateType: NavigateType {
        return .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.paymentStoryboard.getViewController(with: .paymentCardViewController)
        return viewController
    }
    
}
