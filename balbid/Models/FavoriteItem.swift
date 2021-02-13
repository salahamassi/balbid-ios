//
//  Favorite.swift
//  balbid
//
//  Created by Apple on 14/02/2021.
//

import UIKit
import SwiftyJSON

struct FavoriteItem: SwiftyModelData {
    
    let id: Int
    let image: String
    let enterpriseId: String
    let brandId: String
    let barCode: String

    init(json: JSON) {
        id = json["id"].intValue
        image = json["imagefullpath"].stringValue
        enterpriseId = json["enterprise_id"].stringValue
        brandId = json["brand_id"].stringValue
        barCode = json["barcode"].stringValue
    }
    

}


