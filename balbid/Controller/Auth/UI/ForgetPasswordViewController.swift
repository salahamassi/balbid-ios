//
//  ForgetPasswordViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class ForgetPasswordViewController: BaseViewController {

    @IBOutlet weak var loginButton: UIButton!

    override var mustClearNavigationBar: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }

    private func setupNav() {
        self.title = "Forget Password?"
    }

    @IBAction func proceed(_ sender: Any) {
        router?.navigate(to: .forgetPasswordVerifyCodeRoute)
    }

    @IBAction func backToLogin(_ sender: Any) {
        router?.removeAllAndKeep(types: [LoginViewController.self, AccountOptionViewController.self, LoginOptionViewController.self])
    }

}
