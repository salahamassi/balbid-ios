//
//  OrderRoutes.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import AppRouter

enum OrderRoutes {
    case userOrderRoute
}

extension AppRouter {
    func navigate(to route: OrderRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
          case .userOrderRoute:
                mRoute = UserOrderRoute()
                mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}

