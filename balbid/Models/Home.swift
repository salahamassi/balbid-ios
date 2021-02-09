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
    let HomeProductItems: [HomeProductItem]

    init(json: JSON) {
        imageSlider  = json["slider_images"].arrayValue.map { SliderImage(json: $0) }
        banners = json["banners"].arrayValue.map { Banner(json: $0) }
        HomeProductItems = json["home_sliders"].arrayValue.map { HomeProductItem(json: $0) }
    }
}
