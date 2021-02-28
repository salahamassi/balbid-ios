//
//  CommentItem.swift
//  balbid
//
//  Created by Apple on 28/02/2021.
//

import UIKit

import Foundation
import SwiftyJSON

struct CommentItem: SwiftyModelData {
    
    let id: String
    let comment: String
    let commentEvaluation: CommentEvaluation
    let createdAt: String

    init(json: JSON) {
        id = json["id"].stringValue
        comment = json["name"].stringValue
        commentEvaluation = CommentEvaluation(json: json["evaluation"])
        createdAt = json["created_at"].stringValue
    }
    

}
