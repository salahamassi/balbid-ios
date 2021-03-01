//
//  EvaluationFooterCell.swift
//  balbid
//
//  Created by Apple on 01/03/2021.
//

import UIKit

class EvaluationFooterCell: UITableViewCell {
    
    weak var delegate: EvaluationFooterCellDelegate?
    @IBOutlet  weak var loadMoreButton: UIButton!
    
    
    @IBAction func loadMore(_ sender: UIButton) {
        loadMoreButton.loadingIndicator(true,indicatorColor: UIColor.appColor(.primaryColor) ?? .clear)
        delegate?.loadMore(self)
    }
   

}


protocol EvaluationFooterCellDelegate: class {
   func loadMore(_ evaluationFooterCell: EvaluationFooterCell)
}
