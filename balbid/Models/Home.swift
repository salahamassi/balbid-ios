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

    init(json: JSON) {
        imageSlider = json["slider_images"].arrayObject as? [SliderImage] ?? []
    }
}
