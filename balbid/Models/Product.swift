//
//  Product.swift
//  balbid
//
//  Created by Apple on 16/02/2021.
//

import UIKit

import Foundation
import SwiftyJSON

struct Product: SwiftyModelData {
    
    var productItems: [ProductItem]

    init(json: JSON) {
        productItems = json.arrayValue.map {ProductItem(json: $0)}
    }
    

}
