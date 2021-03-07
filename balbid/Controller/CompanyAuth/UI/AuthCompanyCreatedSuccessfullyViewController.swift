//
//  AuthCompanyCreatedSuccessfullyViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 25/12/2020.
//

import UIKit

class AuthCompanyCreatedSuccessfullyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToHome(_ sender : Any){
        router?.navigate(to: AuthRoutes.loginOptionRoute(transitioningDelegate: nil))
    }
}
