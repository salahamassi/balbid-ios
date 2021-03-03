//
//  EvaluationItem.swift
//  balbid
//
//  Created by Apple on 28/02/2021.
//


import UIKit

import Foundation
import SwiftyJSON

struct EvaluationItem: SwiftyModelData {
    
    let rating1: String
    let rating2: String
    let rating3: String
    let rating4: String
    let rating5: String
    var comments: [CommentItem]
    let evaluateCount: String
    let evaluateAvg: String

    init(json: JSON) {
        rating1 = json["rating_1"].stringValue
        rating2 = json["rating_2"].stringValue
        rating3 = json["rating_3"].stringValue
        rating4 = json["rating_4"].stringValue
        rating5 = json["rating_5"].stringValue
        evaluateCount = json["evaluate_count"].stringValue
        evaluateAvg = json["evaluate_avg"].stringValue
        comments =  json["comments"].arrayValue.map { CommentItem(json: $0) }
    }
    

}
