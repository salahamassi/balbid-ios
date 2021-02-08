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
    @IBOutlet weak var loginButton: UIButton!

    override var mustClearNavigationBar: Bool {
        true
    }
    
    var validate: ((String, String) -> Void)?
    
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
        router?.remove(types: [RegisterViewController.self])
        router?.navigate(to: .registerRoute)
    }
    
    private func reset(){
        [emailTextField, passwordTextField].forEach {
            $0?.isError = false
        }
        errorLabel.isHidden = true
        errorLabel.text = nil
    }
    
    @IBAction func login(_ sender: Any) {
        guard  let email = emailTextField.text,
               let password = passwordTextField.text
        else {
            return
        }
        reset()
        validate?(email, password)
    }
    
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func validationError(errorMessage: String, withEntry errorEntry: LoginViewModel.ErrorEntryType) {
        if errorEntry == .email {
            emailTextField.isError = true
        }else{
            passwordTextField.isError = true
        }
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    func apiError(error: String) {
        loginButton.loadingIndicator(false)
        displayAlert(message: error)
    }
    
    func startProgress() {
        reset()
        loginButton.loadingIndicator(true)
    }
    
    func loginSuccees() {
        loginButton.loadingIndicator(false)
        router?.navigate(to: .mainTabBarRoute)
    }
    
}




