//
//  ShippingRoutes.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import Foundation
import AppRouter

enum ShippingRoutes {
    case shippingAddressRoute
    case addNewShippingRoute
    case shippingMapRoute
}

extension AppRouter {
    func navigate(to route: ShippingRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .shippingAddressRoute:
                  mRoute = ShippingAdressRoute()
                  mParams = nil
            case .addNewShippingRoute:
                  mRoute = AddNewShippingRoute()
                  mParams = nil
            case .shippingMapRoute:
                  mRoute = ShippingMapRoute()
                  mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}

