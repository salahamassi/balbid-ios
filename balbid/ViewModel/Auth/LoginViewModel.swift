//
//  LoginViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import UIKit

class LoginViewModel: NSObject {
    
    let delegate: LoginViewModelDelegate!
    
    required init(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func login(email: String, password: String){
        if password.isEmpty{
            delegate.loginViewModel(self, displayError: "Password Must be filled",withEntry: .password)
        }
        if !email.isValidEmail() {
            delegate.loginViewModel(self, displayError: "Invalid Email",withEntry: .email)
        } 
    }
    
    enum ErrorEntryType {
       case email, password
    }
    
}


protocol LoginViewModelDelegate {
    func loginViewModel(_ loginViewModel: LoginViewModel, displayError errorMessage: String, withEntry errorEntry: LoginViewModel.ErrorEntryType)
    
}
