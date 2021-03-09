//
//  CartItem.swift
//  balbid
//
//  Created by Apple on 08/03/2021.
//

import UIKit

import Foundation
import SwiftyJSON

struct CartItem: SwiftyModelData {
    let id: Int
    var totalPrice: String
    let itemPrice: String
    let products: ProductItem
    var quantity: String

    init(json: JSON) {
        id = json["id"].intValue
        totalPrice = json["total_price"].stringValue
        itemPrice = json["item_price"].stringValue
        quantity = json["quantity"].stringValue
        products = ProductItem(json: json["product"])
    }
    
}
