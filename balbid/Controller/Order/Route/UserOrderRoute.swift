//
//  UserOrderRoute.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit
import AppRouter

class UserOrderRoute: Route{
    var navigateType: NavigateType{
        .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.orderStoryboard.getViewController(with: .userOrderViewController)
        return viewController
    }
    
    
}
