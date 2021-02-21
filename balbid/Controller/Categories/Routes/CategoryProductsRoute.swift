//
//  AdCategoriesViewRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import AppRouter

class CategoryProductsRoute: Route {
    
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
        let viewController = UIStoryboard.categoriesStoryboard.getViewController(with: .adCategoriesViewController) as! CategoryProductsViewController
        let viewModel = CategoryProductsViewModel(dataSource: AppDataSource())
        viewModel.delegate = viewController
        viewController.loadProducts = viewModel.getProductCategory
        viewController.addToFavorite = viewModel.addProductToFavorite
        viewController.deleteFavorite = viewModel.removeProductFromFavorite
        viewController.category = params?["category"] as? CategoryItem
        return viewController
    }

}
