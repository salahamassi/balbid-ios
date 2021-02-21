//
//  OptionItem.swift
//  balbid
//
//  Created by Apple on 22/02/2021.
//

import UIKit

import Foundation
import SwiftyJSON

struct OptionItem: SwiftyModelData {
    
    let id: Int
    let name: String

    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
    

}
