//
//  PointRoute.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit
import AppRouter

class PointRoute: Route {
    var navigateType: NavigateType {
        return .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let vc = UIStoryboard.profileStoryboard.getViewController(with: .pointViewController)
        return vc
    }
}
