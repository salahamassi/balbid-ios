//
//  ProductRoutes.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import AppRouter

enum ProductRoutes {
    case productDetailRoute
}

extension AppRouter {
    func navigate(to route: ProductRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
          case .productDetailRoute:
                mRoute = ProductDetailRoute()
                mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
