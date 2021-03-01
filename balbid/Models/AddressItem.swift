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

    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        familyName = json["family_name"].stringValue
    }
    
}
