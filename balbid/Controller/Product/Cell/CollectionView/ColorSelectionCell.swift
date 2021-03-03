//
//  ColorSelectionCell.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class ColorSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    var color: String? {
        didSet {
            if(color != nil) {
                colorView.backgroundColor = UIColor(hexString: color ?? "#00000000")
            }
        }
    }
}
