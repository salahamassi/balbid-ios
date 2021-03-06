//
//  AddedToCartViewController.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class AddedToCartViewController: BaseViewController {
    
    override var mustHideNavigationBar: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToShopping(_ sender: Any){
        router?.popToRootViewController()
        guard  let tabBarController = (router?.window.rootViewController as? UITabBarController) else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tabBarController.selectedIndex = .zero
        }
    }
}
