//
//  EvaluationCell.swift
//  balbid
//
//  Created by Apple on 28/02/2021.
//

import UIKit
import Cosmos

class EvaluationCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: CommentItem?   {
        didSet {
            
        }
    }
    
    private func setupEvaluationData(comment: CommentItem?) {
        guard let comment = comment else {
            return
        }
        ratingView.rating = Double(comment.commentEvaluation.evaluate) ?? 0.0
        dateLabel.text = comment.createdAt
        commentLabel.text = comment.comment
        
    }
        


}
