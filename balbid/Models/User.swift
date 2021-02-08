//
//  User.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import SwiftyJSON

struct User: SwiftyModelData {
    
    let name: String
    let email: String
    let telephone: String
    let apiToken: String

    init(json: JSON) {
        name = json["name"].stringValue
        email = json["email"].stringValue
        telephone = json["telephone"].stringValue
        apiToken = json["api_token"].stringValue
    }
    
}
