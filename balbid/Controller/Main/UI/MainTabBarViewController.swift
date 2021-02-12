//
//  MainTabBarViewController.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        self.tabBar.tintColor = UIColor.appColor(.primaryColor)
    }
}
