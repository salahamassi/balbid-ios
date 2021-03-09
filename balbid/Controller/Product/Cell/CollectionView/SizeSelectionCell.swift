//
//  SizeSelectionCell.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SizeSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeView: UIView!

    
    var isSelect: Bool = false {
        didSet {
            if isSelect {
                sizeView.borderWidth = 1
                sizeView.borderColor = UIColor.appColor(.primaryColor)
            }else {
                sizeView.borderWidth = 0
            }
        }
    }
    
    var size: String? {
        didSet {
            if(size != nil) {
                sizeLabel.text = size
            }
        }
    }
}
