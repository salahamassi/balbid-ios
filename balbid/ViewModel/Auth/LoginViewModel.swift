//
//  LoginViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import UIKit

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    let source: AppDataSource
    
    
    init(source: AppDataSource) {
        self.source = source
    }
    
    func validate(email: String, password: String){
        var isError = false
        if password.isEmpty{
            delegate?.validationError(errorMessage: "Password Must be filled",withEntry: .password)
            isError = true
        }
        if !email.isValidEmail() {
            delegate?.validationError(errorMessage: "Invalid Email",withEntry: .email)
            isError = true
        }
        
        if !isError {
            delegate?.startProgress()
            source.perform(service: .init(path: .loginPath, domain: .domain, method: .post, params: ["email": email, "password": password]), User.self) { (result) in
                switch result {
                  case .data(let data):
                    let user = data.data as User
                    UserDefaultsManager.token = user.apiToken
                    self.delegate?.loginSuccees()
                  case .failure(let error):
                    self.delegate?.apiError(error: error)
                  default:
                    break
                }
            }
        }
    }
    
    enum ErrorEntryType {
       case email, password
    }
    
}


protocol LoginViewModelDelegate: class {
    func validationError(errorMessage: String, withEntry errorEntry: LoginViewModel.ErrorEntryType)
    func apiError(error: String)
    func startProgress()
    func loginSuccees()
}
