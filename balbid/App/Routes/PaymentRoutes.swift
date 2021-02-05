//
//  PaymentRoutes.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit
import Foundation
import AppRouter

enum PaymentRoutes {
    case paymentCardRoute
    
}

extension AppRouter {
    func navigate(to route: PaymentRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .paymentCardRoute:
                  mRoute = PaymentCardRoute()
                  mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}

