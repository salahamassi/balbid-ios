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
    var total: String
    var cartItem: [CartItem]

    init(json: JSON) {
        id = json["id"].intValue
        total = json["total"].stringValue
        cartItem = json["products"].arrayValue.map {CartItem(json: $0)}
    }
    
}
