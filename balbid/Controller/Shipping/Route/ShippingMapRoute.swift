//
//  ShippingMapRoute.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//


import UIKit
import AppRouter

class ShippingMapRoute: Route {
    
    weak var delegate: ShippingMapViewControllerDelegate?
    
    var navigateType: NavigateType {
        return .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.shippingStoryboard.getViewController(with: .shippingMapViewController) as! ShippingMapViewController
        viewController.delegate = delegate
        return viewController
    }
    
}
