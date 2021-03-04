//
//  AuthorizzedPeopleViewModel.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import UIKit

class AuthorizedPeopleViewModel: NSObject {
    
    weak var delegate: AuthorizedPeopleViewModelDelegate?

    func validate(name: String,email: String, password: String,confirmPassword: String,phoneNumber: String,job: String,row: Int) -> Bool{
        var isValid = true
        if phoneNumber.isEmpty {
            delegate?.validationError(errorMessage: "Invalid Phone Number",withEntry: .phoneNumber, at: row)
            isValid = false
        }
     
        if job.isEmpty{
            delegate?.validationError(errorMessage: "Job Must be filled",withEntry: .job, at: row)
            isValid = false
        }
        if password != confirmPassword {
            delegate?.validationError(errorMessage: "Password Not Matched",withEntry: .password, at: row)
            delegate?.validationError(errorMessage: "Password Not Matched",withEntry: .confirmPassword, at: row)
            isValid = false
        }
        if confirmPassword.isEmpty  {
            delegate?.validationError(errorMessage: "",withEntry: .confirmPassword, at: row)
            isValid = false
        }
        if password.isEmpty{
            delegate?.validationError(errorMessage: "Password Must be filled",withEntry: .password, at: row)
            isValid = false
        }
        if !email.isValidEmail() {
            delegate?.validationError(errorMessage: "Invalid Email",withEntry: .email, at: row)
            isValid = false
        }
        
        if name.isEmpty {
            delegate?.validationError(errorMessage: "name Must be filled",withEntry: .name, at: row)
            isValid = false
        }
        
        
       return isValid
    }
    
    func addAll(authorizedPeople: [AuthorizePeople]) {
        MainCompanyAuthViewModel.sharedManger.params["customers"] = authorizedPeople.map  {$0.toMap()}

    }
    
    
    enum EntryType {
        case email, password, phoneNumber, confirmPassword,name, job
    }
}


protocol AuthorizedPeopleViewModelDelegate: class {
    func validationError(errorMessage: String, withEntry: AuthorizedPeopleViewModel.EntryType, at row: Int)

}
