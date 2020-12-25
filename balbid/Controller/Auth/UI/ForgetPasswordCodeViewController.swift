//
//  ForgetPasswordCodeViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit

class ForgetPasswordCodeViewController: BaseViewController {

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
        router?.navigate(to: .setNewPasswordRoute)
    }

    @IBAction func backToLogin(_ sender: Any) {
        router?.removeAllAndKeep(types: [LoginViewController.self, AccountOptionViewController.self, LoginOptionViewController.self])
    }

}
