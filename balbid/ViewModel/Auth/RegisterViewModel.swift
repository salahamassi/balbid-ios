//
//  RegisterViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import UIKit

class RegisterViewModel: NSObject {
    
    let delegate: RegisterViewModelDelegate!
    
    required init(delegate: RegisterViewModelDelegate) {
        self.delegate = delegate
    }
    
    func register(name:String, email: String, phone: String, password: String, confirmPassword: String){
        if password != confirmPassword {
            delegate.registerViewModel(self, displayError: "Password not matches",withEntry: .confirmPassword)
        }
        if password.isEmpty{
            delegate.registerViewModel(self, displayError: "Password must be filled",withEntry: .password)
        }
        if !phone.isPhoneValid() {
            delegate.registerViewModel(self, displayError: "Invalid Phone Number",withEntry: .phone)
        }
        if !email.isValidEmail() {
            delegate.registerViewModel(self, displayError: "Invalid Email",withEntry: .email)
        }
        if name.isEmpty {
            delegate.registerViewModel(self, displayError: "Name must be filled",withEntry: .name)
        }
        
    }
    
    enum ErrorEntryType {
       case email, password, name, phone, confirmPassword
    }
    
}


protocol RegisterViewModelDelegate {
    func registerViewModel(_ registerViewModelViewModel: RegisterViewModel, displayError errorMessage: String, withEntry errorEntry: RegisterViewModel.ErrorEntryType)
    
}
