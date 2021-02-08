//
//  Status.swift
//  balbid
//
//  Created by Salah Amassi on 06/02/2021.
//

import Foundation

struct Status {

    let code: Int
    let success: Bool
    let message: String
    let errorKey: String
    let errorsList: [String]
}

extension Status: SwiftyModelData{
    
    init(json: JSON) {
        code = json["code"].intValue
        success = json["success"].boolValue
        message = json["message"].stringValue
        errorKey = json["error_key"].stringValue
        errorsList = json["errors_list"].arrayValue.map { $0["message"].stringValue }
    }
}
