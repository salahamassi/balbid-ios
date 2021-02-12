//
//  CreateOrderRoute.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit
import AppRouter

class CreateOrderRoute: Route {
    var navigateType: NavigateType {
        .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.createOrderStoryboard.getViewController(with: .createOrderViewController)
        return viewController
    }
    
}
