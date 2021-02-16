//
//  CategoryItem.swift
//  balbid
//
//  Created by Apple on 15/02/2021.
//

import Foundation
import SwiftyJSON

struct CategoryItem: SwiftyModelData {
    
    let id: Int
    let enterpriseId: String
    let brandId: String
    let name: String
    let image: String

    init(json: JSON) {
        id = json["id"].intValue
        image = json["imagefullpath"].stringValue
        enterpriseId = json["enterprise_id"].stringValue
        brandId = json["brand_id"].stringValue
        name = json["name"].stringValue
    }


}
