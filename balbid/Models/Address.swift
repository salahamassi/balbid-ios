//
//  Address.swift
//  balbid
//
//  Created by Apple on 01/03/2021.
//

import Foundation
import SwiftyJSON

struct Address: SwiftyModelData {
   
    let addresses: [AddressItem]
    
    init(json: JSON) {
        addresses = json.arrayValue.map { AddressItem(json: $0) }
    }
    
    
}
