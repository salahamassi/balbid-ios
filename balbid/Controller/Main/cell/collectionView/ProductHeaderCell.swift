//
//  StrongestOfferHeaderCell.swift
//  balbid
//
//  Created by Qamar Nahed on 30/12/2020.
//

import UIKit

class ProductHeaderCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var shopButton : UIButton!

    
    var homeProductItem: HomeProductItem? {
        didSet {
            titleLabel.text = homeProductItem?.name
            shopButton.borderColor = UIColor(hexString: homeProductItem?.color ?? "#1E2352")
            shopButton.setTitleColor(UIColor(hexString: homeProductItem?.color ?? "#1E2352"), for: .normal)
        }
    }
}
