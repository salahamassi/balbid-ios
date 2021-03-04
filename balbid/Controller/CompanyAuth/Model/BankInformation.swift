//
//  BankInformation.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import Foundation
struct BankInformation {
   let mainBank: String
   let cityName: String
   let holderName: String
   let iban: String
    
    func toMap() ->  [String: String] {
        return ["bank_name": mainBank,
                "city": cityName,
                "holder_name": holderName,
                "iban": iban]
    }

    
}
