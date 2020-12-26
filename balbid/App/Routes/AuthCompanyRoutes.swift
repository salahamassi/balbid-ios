//
//  AuthCompanyRoutes.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import AppRouter

enum AuthCompanyRoutes {
    case authCompanyMainRoute
    case companyHolderInformationRoute
    case authCompanyCreatedSuccessfullyRoute
}

extension AppRouter {
    
    func navigate(to route: AuthCompanyRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
            case .authCompanyMainRoute:
                mRoute = AuthCompanyMainRoute()
                mParams = nil
            case .companyHolderInformationRoute:
                mRoute = CompanyHolderInforamtionRoute()
                mParams = nil
            case .authCompanyCreatedSuccessfullyRoute:
                mRoute = AuthCompanyCreatedSuccessfullyRoute()
                mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
