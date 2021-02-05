//
//  SwiftyModelData.swift
//  balbid
//
//  Created by Salah Amassi on 06/02/2021.
//

import SwiftyJSON

protocol SwiftyModelData {

    init(json: JSON)

    func toJSON() -> JSON
}

extension SwiftyModelData{
            
    func toJSON() -> JSON{ JSON() }
}
