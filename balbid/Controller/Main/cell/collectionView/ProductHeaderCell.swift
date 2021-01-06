//
//  StrongestOfferHeaderCell.swift
//  balbid
//
//  Created by Qamar Nahed on 30/12/2020.
//

import UIKit

class ProductHeaderCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
}
