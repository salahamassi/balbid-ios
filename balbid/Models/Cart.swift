//
//  Cart.swift
//  balbid
//
//  Created by Apple on 08/03/2021.
//

import Foundation
import SwiftyJSON

struct Cart: SwiftyModelData {
    let id: Int
    let total: String
    let cartItem: [CartItem]

    init(json: JSON) {
        id = json["id"].intValue
        total = json["total"].stringValue
        cartItem = json["products"].arrayValue.map {CartItem(json: $0)}
    }
    
}
