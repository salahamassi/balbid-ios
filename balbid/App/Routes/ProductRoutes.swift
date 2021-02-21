//
//  ProductRoutes.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import AppRouter

enum ProductRoutes {
    case productDetailRoute(params: [String: Any])
}

extension AppRouter {
    func navigate(to route: ProductRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
          case .productDetailRoute (let params):
                mRoute = ProductDetailRoute()
                mParams = params
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
