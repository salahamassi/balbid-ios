//
//  Product.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import Foundation
import SwiftyJSON

struct ProductItem: SwiftyModelData {
    
    let id: Int
    let image: String
    let enterpriseId: String
    let brandId: String
    let sortOrder: String
    let name: String
    let description: String
    let price: String
    let barcode: String
    let minQuantity: String
    let maxQuantity: String
    let discount: String?
    var isFavorite: String?
    let images: [String]

    init(json: JSON) {
        id = json["id"].intValue
        image = json["imagefullpath"].stringValue
        enterpriseId = json["enterprise_id"].stringValue
        brandId = json["brand_id"].stringValue
        sortOrder = json["sort_order"].stringValue
        name = json["name"].stringValue
        description = json["description"].stringValue
        price = json["price"].stringValue
        barcode = json["bar_code"].stringValue
        minQuantity = json["price_under_min_quantity"].stringValue
        maxQuantity = json["price_upper_max_quantity"].stringValue
        discount = json["discount"].stringValue
        isFavorite = json["is_favorite"].stringValue
        images = json["images"].arrayValue.map { $0["imagefullpath"].stringValue }
    }
    
    
    
}
