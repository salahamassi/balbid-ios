//
//  Favorite.swift
//  balbid
//
//  Created by Apple on 14/02/2021.
//

import UIKit
import SwiftyJSON

struct Favorite: SwiftyModelData {
    
    let favoriteItems: [FavoriteItem]

    init(json: JSON) {
        favoriteItems = json.arrayValue.map {FavoriteItem(json: $0)}
    }
    

}
