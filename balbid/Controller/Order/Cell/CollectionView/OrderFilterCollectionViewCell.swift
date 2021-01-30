//
//  OrderFilterCollectionViewCell.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class OrderFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    var filter: String = "" {
        didSet{
            filterLabel.text = filter
        }
    }
    
     var isToggeled: Bool = false {
        didSet {
            if(isToggeled){
               containerView.animateBackgroundColorChange(value: UIColor.appColor(.primaryColor) ?? .white)
                filterLabel.textColor = .white
                self.containerView.animateBorder(with: UIColor.appColor(.borderGrayColor) ?? .white, border: 0)
            }else{
                containerView.animateBackgroundColorChange(value: UIColor.appColor(.whiteColor) ?? .white)
                filterLabel.textColor = UIColor.appColor(.primaryColor) ?? .white
                self.containerView.animateBorder(with: UIColor.appColor(.borderGrayColor) ?? .white, border: 1)
            }
        }
    }
}
