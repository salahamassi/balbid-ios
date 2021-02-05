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
//        router?.removeAllAndKeep(types: [HomeViewController.self])
        router?.popToRootViewController()
        guard  let tabBarController = ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? UITabBarController) else {
            return
        }
//        tabBarController.hidesBottomBarWhenPushed = false
        tabBarController.selectedIndex = 0
        
    }


}
