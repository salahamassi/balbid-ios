//
//  OrderItem.swift
//  balbid
//
//  Created by Apple on 14/03/2021.
//

import Foundation
import Foundation
import SwiftyJSON

struct OrderItem: SwiftyModelData {
    let id: Int
    let total: String
  

    init(json: JSON) {
        id = json["id"].intValue
        total = json["total"].stringValue
      
    }
    
}
