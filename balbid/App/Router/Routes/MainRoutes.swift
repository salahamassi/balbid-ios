//
//  MainRoutes.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import Foundation

enum MainRoutes {
    
    case photosPicker(params: [String: Any])
}

extension AppRouter{
    
    func navigate(to route: MainRoutes, completion: (()-> Void)? = nil){
        let mRoute: Route
        let mParams: [String: Any]?
        switch route {
        case .photosPicker(params: let params):
            mRoute = PhotosPickerRoute()
            mParams = params
        }
        navigate(to: mRoute, with: mParams, completion: completion)
    }
    
}
