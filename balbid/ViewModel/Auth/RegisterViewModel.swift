//
//  RegisterViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import Foundation

protocol RegisterViewModelOutput {
    func invalidaName()
    func invalidaEmail()
    func invalidaPhone()
    func invalidaPassword()
    func startProgress()
    func apiError(error: String)
    func registerSuccess()


}

enum FieldType {
    case name
    case email
    case phone
    case password
}

protocol RegisterViewPresenterOutput: class {
    func invalidaField(message: String, field: FieldType)
    func apiError(error: String)
    func startProgress()
    func registerSuccess()
}


class RegisterViewPresenter<Output: RegisterViewPresenterOutput>: RegisterViewModelOutput {
       
    weak var output: Output?
    
    func invalidaName() {
        output?.invalidaField(message: "Name must be filled", field: .name)
    }
    
    func invalidaEmail() {
        output?.invalidaField(message: "Invalide Email", field: .email)
    }
    
    func invalidaPhone() {
        output?.invalidaField(message: "Invalide Phone", field: .phone)
    }
    
    func invalidaPassword() {
        output?.invalidaField(message: "Password must be filled", field: .password)
    }
    
    func apiError(error: String) {
        output?.apiError(error: error)
    }
    
    func startProgress() {
        output?.startProgress()
    }
    
    func registerSuccess() {
        output?.registerSuccess()
    }
    
}


struct RegisterViewModel<Output: RegisterViewModelOutput> {
    
    let dataSource: AppDataSource
    let output: Output
    
    func validate(name:String, email: String, phone: String, password: String) {
        var isError = false
        if password.isEmpty{
            output.invalidaPassword()
            isError = true
        }
        if !phone.isPhoneValid() {
            output.invalidaPhone()
            isError = true
        }
        if !email.isValidEmail() {
            output.invalidaEmail()
            isError = true
        }
        if name.isEmpty {
            output.invalidaName()
            isError = true
        }
        
        if !isError {
            output.startProgress()
            dataSource.perform(service: .init(path: .customerRegisterPath, domain: .domain, method: .post, params: ["name": name, "email": email, "last_name": name, "telephone": phone, "password": password, "password_confirmation": password],mustCaching: true, cachePath: "user"), User.self) { result in
                switch result {
                  case .data(let data):
                    let user = data.data as User
                    UserDefaultsManager.token = user.apiToken
                    output.registerSuccess()
                  case .failure(let error):
                    output.apiError(error: error)
                  default:
                    break
                }
            }
        }
    }
}
