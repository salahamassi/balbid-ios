//
//  CategoriesRoutes.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import AppRouter

enum CategoriesRoutes {
    case adCategoriesRoute
    case categoriesFilterRoute
}


extension AppRouter {
    func navigate(to route: CategoriesRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .adCategoriesRoute:
                mRoute = AdCategoriesRoute()
                mParams = nil
        case .categoriesFilterRoute:
            mRoute = CategoriesFilterRoute()
            mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
