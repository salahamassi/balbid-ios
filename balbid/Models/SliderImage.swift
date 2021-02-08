//
//  HomeSlider.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import Foundation
import SwiftyJSON

struct SliderImage: SwiftyModelData {
    let id: Int
    let image: String
    let enterpriseId: String
    let brandId: String
    let sortOrder: String

    init(json: JSON) {
        id = json["id"].intValue
        image = json["image"].stringValue
        enterpriseId = json["enterprise_id"].stringValue
        brandId = json["brand_id"].stringValue
        sortOrder = json["sort_order"].stringValue
    }
}
