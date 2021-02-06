//
//  RegsiterViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import AppRouter

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: BorderedTextField!
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var phoneTextField: BorderedTextField!
    @IBOutlet weak var passwordTextField: BorderedTextField!

    override var mustClearNavigationBar: Bool {
        true
    }
        
    private var registerViewModel: RegisterViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupViewModel()
    }

    private func setupViewModel(){
        registerViewModel = RegisterViewModel(delegate: self)
    }
    
    private func setupNav() {
        self.title = "Create New Account"
    }

    @IBAction func login(_ sender: Any) {
        router?.remove(types: [LoginViewController.self])
        router?.navigate(to: .loginRoute)
    }
    
    @IBAction func register(_ sender: Any) {
        registerViewModel.register(name: nameTextField.text ?? "", email: emailTextField.text ?? "", phone: phoneTextField.text ?? "", password: passwordTextField.text ?? "", confirmPassword: passwordTextField.text ?? "")
    }
    
}

extension RegisterViewController: RegisterViewModelDelegate {
    func registerViewModel(_ registerViewModelViewModel: RegisterViewModel, displayError errMessage: String, withEntry errorEntry: RegisterViewModel.ErrorEntryType) {
        switch errorEntry {
            case .email:
                emailTextField.isError = true
            case .phone:
                phoneTextField.isError = true
            case .password:
                passwordTextField.isError = true
            case .confirmPassword:
                passwordTextField.isError = true
            case .name:
                nameTextField.isError = true
      
        }
        
        displayAlert(message: errMessage)
    }
    
    
}
