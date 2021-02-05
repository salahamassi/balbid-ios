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
 
}

extension AppRouter {
    func navigate(to route: PaymentRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
        
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}

