//
//  MainTabBarController.swift
//  balbid
//
//  Created by Memo Amassi on 07/02/2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        self.tabBar.tintColor = UIColor.appColor(.primaryColor)
    }


}
