//
//  PaymentMethod.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import Foundation
import SwiftyJSON

struct PaymentMethod: SwiftyModelData {
    let id: Int
    let name: String
    let image: String
    let toCorporate: String

    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        image = json["imagefullpath"].stringValue
        toCorporate = json["to_corporate"].stringValue
    }
    
}
