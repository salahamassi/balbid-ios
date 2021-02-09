//
//  HomeItem.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import Foundation
import SwiftyJSON

struct HomeProductItem: SwiftyModelData {
    
    let id: Int
    let color: String
    let enterpriseId: String
    let brandId: String
    let sortOrder: String
    let name: String
    let prodcuts: [Product]
    init(json: JSON) {
        id = json["id"].intValue
        color = json["color"].stringValue
        enterpriseId = json["enterprise_id"].stringValue
        brandId = json["brand_id"].stringValue
        sortOrder = json["sort_order"].stringValue
        name = json["name"].stringValue
        prodcuts = json["products"].arrayValue.map{ Product(json: $0) }
    }
    
    
}
