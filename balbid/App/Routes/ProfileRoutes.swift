//
//  ProfileRoutes.swift
//  balbid
//
//  Created by Memo Amassi on 23/01/2021.
//

import AppRouter

enum ProfileRoutes {
    case editProfileRoute
    case pointRoute
    case favoriteRoute

}

extension AppRouter {
    func navigate(to route: ProfileRoutes, completion: (() -> Void)? = nil) {
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
          case .editProfileRoute:
                mRoute = EditProfileRoute()
                mParams = nil
        case .pointRoute:
              mRoute = PointRoute()
              mParams = nil
        case .favoriteRoute:
              mRoute = FavoriteRoute()
              mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }

}
