//
//  SystemConstant.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import Foundation
import SwiftyJSON

struct SystemConstant: SwiftyModelData {
    var paymentMethods: [PaymentMethod]
    
    init(json: JSON) {
        paymentMethods = json["payment_methods"].arrayValue.map {PaymentMethod(json:$0)}
        paymentMethods = paymentMethods.filter({ (paymentMethod) -> Bool in
            paymentMethod.toCorporate == "0"
        })
    }
    
}
