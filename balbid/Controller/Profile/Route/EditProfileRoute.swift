//
//  EditProfileRoute.swift
//  balbid
//
//  Created by Memo Amassi on 23/01/2021.
//

import UIKit
import AppRouter

class EditProfileRoute: Route {
    var navigateType: NavigateType {
        return .push
    }
    
    func create(_ router: AppRouter, _ params: [String : Any]?) -> UIViewController {
        let viewController = UIStoryboard.profileStoryboard.getViewController(with: .editProfileViewController)
        
        return viewController
    }
}
