//
//  LoginViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit

class LoginOptionViewController: BaseViewController {
    @IBOutlet weak var splashLogoImageView : UIImageView!
    
    @IBAction func login(sender  : UIButton){
        
    }

    @IBAction func createAccount(sender  : UIButton){
        AppRouter().navigate(to: .accountOptionViewController)
        
    }
    
    @IBAction func continueAsGuest(sender  : UIButton){
        
    }
}
