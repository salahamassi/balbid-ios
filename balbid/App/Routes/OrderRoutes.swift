//
//  OrderRoutes.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import AppRouter

enum OrderRoutes {
    case userOrderRoute
    case orderDetailRoute
    case productRatingRoute
    case productTraceRoute
    case orderTraceMapRoute
    case reorderRoute
    case addedToCartRoute
}

extension AppRouter {
    func navigate(to route: OrderRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
          case .userOrderRoute:
                mRoute = UserOrderRoute()
                mParams = nil
          case .orderDetailRoute:
                mRoute = OrderDetailRoute()
                mParams = nil
          case .productTraceRoute:
                mRoute = ProductTraceRoute()
                mParams = nil
          case .productRatingRoute:
                mRoute = ProductRatingRoute()
                mParams = nil
          case .orderTraceMapRoute:
                mRoute = OrderTraceMapRoute()
                mParams = nil
         case .reorderRoute:
              mRoute = ReorderRoute()
              mParams = nil
         case .addedToCartRoute:
             mRoute = AddedToCartRoute()
             mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}

