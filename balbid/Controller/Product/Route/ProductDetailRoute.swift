//
//  ProductDetailRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit
import AppRouter
class ProductDetailRoute: Route {
    var navigateType: NavigateType {
        return  .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailViewController) as!  ProductDetailViewController
        guard let product =  params?["product"] as? ProductItem else {
            fatalError("you must provide product data")
        }
        viewController.product = product
        let viewModel = ProductViewModel(dataSource: AppDataSource())
        viewController.loadProduct = viewModel.getProductData
        viewModel.delegate = viewController
        return viewController
    }
    

   

}
