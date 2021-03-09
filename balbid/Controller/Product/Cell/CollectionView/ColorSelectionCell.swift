//
//  ColorSelectionCell.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class ColorSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    var isSelect: Bool = false {
        didSet {
            if isSelect {
                colorView.borderWidth = 2
                colorView.borderColor = UIColor.appColor(.primaryColor)
            }else {
                colorView.borderWidth = 1
                colorView.borderColor = UIColor.appColor(.lightGrayColor)
            }
        }
    }
    
    var color: String? {
        didSet {
            if(color != nil) {
                colorView.backgroundColor = UIColor(hexString: color ?? "#00000000")
            }
        }
    }
}
