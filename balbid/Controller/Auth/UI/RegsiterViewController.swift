//
//  RegsiterViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class RegsiterViewController: BaseViewController {

    override var mustClearNavigationBar: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }

    private func setupNav() {
        self.title = "Create New Account"

    }

    @IBAction func login(_ sender: Any) {
        router?.remove(types: [LoginViewController.self])
        router?.navigate(to: .loginRoute)
    }
}
