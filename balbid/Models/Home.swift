//
//  Home.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import Foundation
import SwiftyJSON

struct Home: SwiftyModelData {
    let imageSlider: [SliderImage]
    let banners: [Banner]
    var homeProductItems: [HomeProductItem] = []

    init(json: JSON) {
        imageSlider  = json["slider_images"].arrayValue.map { SliderImage(json: $0) }
        banners = json["banners"].arrayValue.map { Banner(json: $0) }
        homeProductItems = json["home_sliders"].arrayValue.map { HomeProductItem(json: $0) }
        homeProductItems = homeProductItems.sorted(by: { (item1, item2) -> Bool in
            Int(item1.sortOrder) ?? 0 < Int(item2.sortOrder) ?? 0
        })
    }
}
