//
//  BaseModel.swift
//  balbid
//
//  Created by Salah Amassi on 06/02/2021.
//

import SwiftyJSON

struct BaseModel<E: SwiftyModelData> {

    let success: Bool
    let data: E
    let message: String
}

extension BaseModel: SwiftyModelData{
    
    init(json: JSON) {
        success = json["success"].boolValue
        data = E(json: json["data"])
        message = json["success"].stringValue
    }
}
