//
//  SystemConstant.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import Foundation
import SwiftyJSON

struct SystemConstant: SwiftyModelData {
    let paymentMethods: [PaymentMethod]
    
    init(json: JSON) {
        paymentMethods = json["payment_methods"].arrayValue.map {PaymentMethod(json:$0)}
    }
    
}
