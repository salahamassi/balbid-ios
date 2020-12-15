//
//  SplashViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var splashLogoImageView : UIImageView!
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            AppRouter().navigate(to: .loginOptionViewController)
        }
    }
}
