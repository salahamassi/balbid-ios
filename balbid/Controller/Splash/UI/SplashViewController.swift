//
//  SplashViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit
import AppRouter

class SplashViewController: BaseViewController {

    @IBOutlet weak var splashLogoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            UserDefaultsManager.token = nil
            if UserDefaultsManager.token != nil {
                self.router?.navigate(to: .mainTabBarRoute)
            }else{
                self.router?.navigate(to: AuthRoutes.loginOptionRoute(transitioningDelegate: LoginTransitioningDelegate()))
            }
                
        }
    }
}
