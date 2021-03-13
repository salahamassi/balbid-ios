//
//  CreateOrderRoutes.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit
import Foundation
import AppRouter

enum CreateOrderRoutes {
    case createOrderRoute(params: [String: Any])
    case orderCreatedSuccessfullyRoute

}

extension AppRouter {
    func navigate(to route: CreateOrderRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .createOrderRoute(let params):
                  mRoute = CreateOrderRoute()
                  mParams = params
        case .orderCreatedSuccessfullyRoute:
                mRoute = OrderCreatedSuccessfullyRoute()
                mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}


