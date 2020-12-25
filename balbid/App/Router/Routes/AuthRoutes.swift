//
//  AuthRoute.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import AppRouter

enum AuthRoutes {
    case loginOptionRoute
    case accountOptionRoute
    case registerRoute
    case loginRoute
    case forgetPasswordRoute
    case forgetPasswordVerifyCodeRoute
    case setNewPasswordRoute

}
extension AppRouter {

    func navigate(to route: AuthRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .loginOptionRoute:
                mRoute = LoginOptionRoute()
                mParams = nil
            case .accountOptionRoute:
                mRoute = AccountOptionRoute()
                mParams = nil
            case .registerRoute:
                mRoute = RegisterRoute()
                mParams = nil
            case .loginRoute:
                mRoute = LoginRoute()
                mParams = nil
            case .forgetPasswordRoute:
                mRoute = ForgetPasswordRoute()
                mParams = nil
            case .forgetPasswordVerifyCodeRoute:
                mRoute = ForgetPasswordCodeRoute()
                mParams = nil
            case .setNewPasswordRoute:
                mRoute = SetNewPasswordRoute()
                mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
