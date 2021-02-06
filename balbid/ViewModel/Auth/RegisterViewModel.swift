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
        if name.isEmpty {
            delegate.registerViewModel(self, displayError: "Name must be filled",withEntry: .name)
        }else if !email.isValidEmail() {
            delegate.registerViewModel(self, displayError: "Invalid Email",withEntry: .email)
        }else if !phone.isValidEmail() {
            delegate.registerViewModel(self, displayError: "Invalid Phone Number",withEntry: .phone)
        }else if password.isEmpty{
            delegate.registerViewModel(self, displayError: "Password must be filled",withEntry: .password)
        }else if password != confirmPassword {
            delegate.registerViewModel(self, displayError: "Password not matches",withEntry: .confirmPassword)
        }else{
            //TO Do Perform Login Api
        }
        
    }
    
    enum ErrorEntryType {
       case email, password, name, phone, confirmPassword
    }
    
}


protocol RegisterViewModelDelegate {
    func registerViewModel(_ registerViewModelViewModel: RegisterViewModel, displayError errMessage: String, withEntry errorEntry: RegisterViewModel.ErrorEntryType)
    
}
