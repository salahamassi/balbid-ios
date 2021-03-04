//
//  AuthorizePeople.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import Foundation


struct AuthorizePeople {
    let name: String
    let password: String
    let email: String
    let phone: String
    
    func toMap() ->  [String: String] {
        return ["name": name,
                "email": email,
                "password": password,
                "telephone": phone]
    }

}
