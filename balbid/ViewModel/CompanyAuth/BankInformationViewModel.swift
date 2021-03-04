//
//  BankInformationViewModel.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import UIKit

class BankInformationViewModel: NSObject {
    
    weak var delegate: BankInformationViewModelDelegate?

    func validate(mainBank: String,cityName: String, holderName: String,iban: String,row: Int) -> Bool{
        var isValid = true
        if iban.isEmpty  {
            delegate?.validationError(errorMessage: "you should enter account iban",withEntry: .iban, at: row)
            isValid = false
        }
        if holderName.isEmpty{
            delegate?.validationError(errorMessage: "you should enter account holder name",withEntry: .holderName, at: row)
            isValid = false
        }
        if cityName.isEmpty {
            delegate?.validationError(errorMessage: "City Named  must be filled",withEntry: .cityName, at: row)
            isValid = false
        }
        
        if mainBank.isEmpty {
            delegate?.validationError(errorMessage: "bank name must be filled",withEntry: .mainBank, at: row)
            isValid = false
        }
        
        
       return isValid
    }
    
    func addAll(banksInformation: [BankInformation]) {
        MainCompanyAuthViewModel.sharedManger.params["banks"] = banksInformation.map  {$0.toMap()}

    }
    
    
    enum EntryType {
        case mainBank, cityName, holderName,iban
    }
}


protocol BankInformationViewModelDelegate: class {
    func validationError(errorMessage: String, withEntry: BankInformationViewModel.EntryType, at row: Int)

}
