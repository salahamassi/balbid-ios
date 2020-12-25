//
//  RegisterViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit

class LoginViewController: BaseViewController {

    override var mustClearNavigationBar: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }

    private func setupNav() {
        self.title = "Login"
    }

    @IBAction func goToForgetPasswordScreen(_ sender: Any) {
        router?.navigate(to: .forgetPasswordRoute)
    }

    @IBAction func signup(_ sender: Any) {
        router?.remove(types: [RegsiterViewController.self])
        router?.navigate(to: .registerRoute)
    }

}
