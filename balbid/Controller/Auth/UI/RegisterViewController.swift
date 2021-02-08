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
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    override var mustClearNavigationBar: Bool {
        true
    }
    
    var validate: ((String, String, String, String)-> Void)?
    
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
    
    @IBAction func register(_ sender: Any) {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let phone = phoneTextField.text,
              let password = passwordTextField.text
        else { return }
        reset()
        validate?(name, email, phone, password)
    }
    
    private func reset(){
        [nameTextField, emailTextField, phoneTextField, passwordTextField].forEach {
            $0?.isError = false
        }
        errorLabel.isHidden = true
        errorLabel.text = nil
    }

}

extension RegisterViewController: RegisterViewPresenterOutput {
    func registerSuccess() {
        registerButton.loadingIndicator(false)
        router?.navigate(to: .mainTabBarRoute)
    }
    
    func startProgress() {
        reset()
        registerButton.loadingIndicator(true)
    }
    
    
    func apiError(error: String) {
        registerButton.loadingIndicator(false)
        displayAlert(message: error)
    }
    
    func invalidaField(message: String, field: FieldType) {
        switch field {
        case .name:
            nameTextField.isError = true
        case .email:
            emailTextField.isError = true
        case .phone:
            phoneTextField.isError = true
        case .password:
            passwordTextField.isError = true
        }
        errorLabel.isHidden = false
        errorLabel.text = message
    }

}

