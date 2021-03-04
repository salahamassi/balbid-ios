//
//  CompanyHolderInformationViewModel.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class CompanyHolderInformationViewModel: NSObject {

    weak var delegate: CompanyHolderInformationViewModelDelegate?

    func validate(holderName: String,email: String, password: String,confirmPassword: String, civilNumber: String,source: String,releaseData: String?,
                  endDate: String?,phoneNumber: String) -> Bool{
        var isValid = true
        if phoneNumber.isEmpty {
            delegate?.validationError(errorMessage: "Invalid Phone Number",withEntry: .phoneNumber)
            isValid = false
        }
        if endDate?.isEmpty ?? true {
            delegate?.validationError(errorMessage: "End date Must be filled",withEntry: .endDate)
            isValid = false
        }
        if releaseData?.isEmpty ?? true {
            delegate?.validationError(errorMessage: "Release date Must be filled",withEntry: .releaseDate)
            isValid = false
        }
        if source.isEmpty{
            delegate?.validationError(errorMessage: "Company Soucr Must be filled",withEntry: .source)
            isValid = false
        }
        if civilNumber.isEmpty{
            delegate?.validationError(errorMessage: "Civil Number Must be filled",withEntry: .civilNumber)
            isValid = false
        }
       
        if confirmPassword.isEmpty  {
            delegate?.validationError(errorMessage: "",withEntry: .confirmPassword)
            isValid = false
        }
        if password != confirmPassword {
            delegate?.validationError(errorMessage: "Password Not Matched",withEntry: .password)
            delegate?.validationError(errorMessage: "Password Not Matched",withEntry: .confirmPassword)
            isValid = false
        }
        if password.isEmpty{
            delegate?.validationError(errorMessage: "Password Must be filled",withEntry: .password)
            isValid = false
        }
        if !email.isValidEmail() {
            delegate?.validationError(errorMessage: "Invalid Email",withEntry: .email)
            isValid = false
        }
        
        if holderName.isEmpty {
            delegate?.validationError(errorMessage: "Company Holder Name Must be filled",withEntry: .holderName)
            isValid = false
        }
        
        if isValid {
            MainCompanyAuthViewModel.sharedManger.params["owner_name"] = holderName
            MainCompanyAuthViewModel.sharedManger.params["owner_telephone"] = phoneNumber
            MainCompanyAuthViewModel.sharedManger.params["owner_password"] = password
            MainCompanyAuthViewModel.sharedManger.params["owner_password_confirmation"] = password
            MainCompanyAuthViewModel.sharedManger.params["owner_email"] = email
            MainCompanyAuthViewModel.sharedManger.params["civil_registry_no"] = civilNumber
            MainCompanyAuthViewModel.sharedManger.params["civil_registry_source"] = source
            MainCompanyAuthViewModel.sharedManger.params["civil_registry_release_date"] = releaseData
            MainCompanyAuthViewModel.sharedManger.params["civil_registry_expiry_date"] = endDate
        }
        
        
       return isValid
    }
    
    
    enum EntryType {
        case email, password, phoneNumber, confirmPassword,holderName, civilNumber, source,  releaseDate, endDate
    }
}


protocol CompanyHolderInformationViewModelDelegate: class {
    func validationError(errorMessage: String, withEntry: CompanyHolderInformationViewModel.EntryType)
}
