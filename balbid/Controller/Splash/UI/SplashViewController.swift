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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            UserDefaultsManager.token = nil
            print(UserDefaultsManager.token)
            if UserDefaultsManager.token != nil {
                self.router?.navigate(to: .mainTabBarRoute)
            }else{
                self.router?.navigate(to: .loginOptionRoute)
            }
                
        }
    }
    
    
}
