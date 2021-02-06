//
//  RegisterViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var passwordTextField: BorderedTextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var loginViewModel: LoginViewModel!

    override var mustClearNavigationBar: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupViewMode()
    }

    private func setupNav() {
        self.title = "Login"
    }
    
    private func setupViewMode(){
        loginViewModel = LoginViewModel(delegate: self)
    }

    @IBAction func goToForgetPasswordScreen(_ sender: Any) {
        router?.navigate(to: .forgetPasswordRoute)
    }

    @IBAction func signup(_ sender: Any) {
        router?.remove(types: [RegisterViewController.self])
        router?.navigate(to: .registerRoute)
    }

    @IBAction func login(_ sender: Any) {
        loginViewModel.login(email: emailTextField.text ?? "" , password: passwordTextField.text ?? "")
    }
    
    
}

extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(_ loginViewModel: LoginViewModel, displayError errorMessage: String, withEntry errorEntry: LoginViewModel.ErrorEntryType) {
        if errorEntry == .email {
            emailTextField.isError = true
        }else{
            passwordTextField.isError = true
        }
        errorLabel.isHidden = false 
        errorLabel.text = errorMessage
    }
    
    
}




