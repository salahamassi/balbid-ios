//
//  ProductTrackRoute.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit
import AppRouter

class ProductTraceRoute: Route {
    var navigateType: NavigateType{
        .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.orderStoryboard.getViewController(with: .productTraceViewController)
        return viewController
    }
}
