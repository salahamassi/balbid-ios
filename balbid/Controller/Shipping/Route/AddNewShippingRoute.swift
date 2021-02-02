//
//  AddNewShippingRoute.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit
import AppRouter

class AddNewShippingRoute: Route {
    var navigateType: NavigateType {
        return .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.shippingStoryboard.getViewController(with: .addNewShippingViewController)
        return viewController
    }
    
}
