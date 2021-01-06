//
//  CategoriesFilterRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit
import AppRouter

class CategoriesFilterRoute: Route {

    var navigateType: NavigateType {
        .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.categoriesStoryboard.getViewController(with: .categoriesFilterViewController)
        return viewController
    }

}
