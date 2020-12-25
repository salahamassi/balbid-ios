//
//  MainRoutes.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import AppRouter

enum MainRoutes {

    case photosPicker(params: [String: Any])
    case splashRoute
    case mainTabBarRoute

}

extension AppRouter {

    func navigate(to route: MainRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
        case .photosPicker(params: let params):
            mRoute = PhotosPickerRoute()
            mParams = params
        case .splashRoute:
            mRoute = SplashRoute()
            mParams = nil
        case .mainTabBarRoute:
            mRoute = MainTabBarRoute()
            mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
