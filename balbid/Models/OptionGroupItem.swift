//
//  OptionGroup.swift
//  balbid
//
//  Created by Apple on 22/02/2021.
//

import UIKit

import Foundation
import SwiftyJSON

struct OptionGroupItem: SwiftyModelData {
    
    let id: Int
    let optionGroupId: String
    let options: [OptionItem]
    let optionType: OptionType

    init(json: JSON) {
        id = json["id"].intValue
        optionGroupId = json["option_group_id"].stringValue
        optionType = OptionType(rawValue: optionGroupId) ?? .color
        options = json["product_option_group_options"].arrayValue.map { OptionItem(json: $0["option"]) }
    }
    

}
enum OptionType: String {
    case color = "1"
    case size = "2"
}
