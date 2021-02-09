//
//  AdCategoriesViewRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import AppRouter

class AdCategoriesRoute: Route {
    
    var navigateType: NavigateType {
        .push
    }
    
    var transition: CATransition? {
        .fadeTransition
    }
    
    var animated: Bool {
        false
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.categoriesStoryboard.getViewController(with: .adCategoriesViewController)
        return viewController
    }

}
