//
//  LoginViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit

class LoginOptionViewController: BaseViewController {

    override var mustClearNavigationBar: Bool {
        true
    }

    @IBOutlet weak var splashLogoImageView: UIImageView!

    @IBAction func login(sender: UIButton) {
        router?.navigate(to: .loginRoute)

    }

    @IBAction func createAccount(sender: UIButton) {
        router?.navigate(to: .accountOptionRoute)
    }

    @IBAction func continueAsGuest(sender: UIButton) {}
}
