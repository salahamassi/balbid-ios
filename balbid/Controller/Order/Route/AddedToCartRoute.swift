//
//  AddedToCartRoute.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit
import AppRouter

class AddedToCartRoute: Route {
    var navigateType: NavigateType{
        .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.orderStoryboard.getViewController(with: .addedToCartViewController)
        return viewController
    }
    
}
