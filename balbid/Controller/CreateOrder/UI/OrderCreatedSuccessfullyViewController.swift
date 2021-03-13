//
//  OrderCreatedSuccessfullyViewController.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit

class OrderCreatedSuccessfullyViewController: BaseViewController {
    
    override var mustHideNavigationBar: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func viewInitialBill(_ sender: Any) {
        
    }
    
    @IBAction func backToShopping(_ sender: Any) {
        backToHome(selectedIndex: 0)
    }
    
    func backToHome(selectedIndex: Int) {
        router?.popToRootViewController()
        guard  let tabBarController = ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? UITabBarController) else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            tabBarController.selectedIndex = selectedIndex
        }
    }

}
