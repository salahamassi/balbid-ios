//
//  CommentEvaluation.swift
//  balbid
//
//  Created by Apple on 28/02/2021.
//

import Foundation
import SwiftyJSON

struct CommentEvaluation: SwiftyModelData {
    
    let evaluate: String
    
    init(json: JSON) {
        evaluate = json["evaluate"].stringValue
    }
    

}
