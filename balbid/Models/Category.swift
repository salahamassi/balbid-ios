//
//  Category.swift
//  balbid
//
//  Created by Apple on 15/02/2021.
//

import Foundation
import SwiftyJSON

struct Category: SwiftyModelData {
    
    var categoryItems: [CategoryItem]

    init(json: JSON) {
        categoryItems = json.arrayValue.map {CategoryItem(json: $0)}
    }
    

}
