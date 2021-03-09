//
//  SizeSelectionCell.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SizeSelectionCell: UICollectionViewCell {
    @IBOutlet weak var sizeLabel: UILabel!
    
    var size: String? {
        didSet {
            if(size != nil) {
                sizeLabel.text = size
            }
        }
    }
}
