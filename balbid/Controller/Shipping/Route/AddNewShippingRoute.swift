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
        let viewController = UIStoryboard.shippingStoryboard.getViewController(with: .addNewShippingViewController) as! AddNewShippingViewController
        let viewModel = AddNewAddressViewModel(dataSource: AppDataSource())
        viewModel.delegate = viewController
        viewController.addNewShipping = viewModel.addNewAddress
        return viewController
    }
    
}
