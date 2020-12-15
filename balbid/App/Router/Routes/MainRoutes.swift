//
//  MainRoutes.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import Foundation

enum MainRoutes {
    
    case photosPicker(params: [String: Any])
    case splashViewController
    case loginOptionViewController
    case accountOptionViewController

}

extension AppRouter{
    
    func navigate(to route: MainRoutes, completion: (()-> Void)? = nil){
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
        case .photosPicker(params: let params):
            mRoute = PhotosPickerRoute()
            mParams = params
        case .splashViewController:
            mRoute = SplashRoute()
            mParams = nil
        case .loginOptionViewController:
            mRoute = LoginOptionRoute()
            mParams = nil
        case .accountOptionViewController:
            mRoute = AccountOptionRoute()
            mParams = nil
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }
    
}
