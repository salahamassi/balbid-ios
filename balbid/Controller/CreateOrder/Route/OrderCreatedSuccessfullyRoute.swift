//
//  OrderCreatedSuccessfullyRoute.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit
import AppRouter

class OrderCreatedSuccessfullyRoute: Route {
    var navigateType: NavigateType {
        .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.createOrderStoryboard.getViewController(with: .orderCreatedSuccessfullyViewController)
        return viewController
    }
}
