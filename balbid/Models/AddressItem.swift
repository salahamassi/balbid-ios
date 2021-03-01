//
//  AddressItem.swift
//  balbid
//
//  Created by Apple on 01/03/2021.
//

import Foundation
import SwiftyJSON

struct AddressItem: SwiftyModelData {
    let id: Int
    let name: String
    let familyName: String
    let country: String
    let neighborhood: String
    let city: String
    let mobileNumber: String
    let region: String

    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        familyName = json["family_name"].stringValue
        country = json["country"].stringValue
        neighborhood = json["neighborhood"].stringValue
        city = json["city"].stringValue
        mobileNumber = json["mobile"].stringValue
        region = json["region"].stringValue
    }
    
}
