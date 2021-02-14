//
//  CreateOrderRoutes.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit
import Foundation
import AppRouter

enum CreateOrderRoutes {
    case createOrderRoute
    
}

extension AppRouter {
    func navigate(to route: CreateOrderRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .createOrderRoute:
                  mRoute = CreateOrderRoute()
                  mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}


