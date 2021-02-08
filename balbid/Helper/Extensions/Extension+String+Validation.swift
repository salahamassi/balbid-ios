//
//  Extension+String+Validation.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import Foundation


extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isPhoneValid() -> Bool{
        let PHONE_REGEX = "^(05)(5|0|3|6|4|9|1|8|7)([0-9]{7})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
}
