//
//  WholeSaleOfferHeaderCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 30/12/2020.
//

import UIKit

class WholeSaleOfferHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.withShadow(color: .black, alpha: 0.3, x: 3, y: 3, blur: 10, spread: 0)

    }

}
