//
//  ReorderCell.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class ReorderCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionImageView: UIImageView!

    
    var isChecked: Bool = false {
        didSet{
            selectionImageView.animateIsHidden(value: !isChecked)
            selectionView.animateBackgroundColorChange(value: isChecked ? UIColor.appColor(.primaryColor) ?? .white : .white)
            selectionView.borderWidth = isChecked ? 0 : 1
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.withShadow(color: .black, alpha: 0.1, x: 0, y: 3, blur: 14, spread: 0)
    }

    @IBAction func changeQuantity(_ sender: UIButton){
        var quantity = Int(quantityLabel.text!) ?? 0
        if sender.tag == 0 {
            quantity += 1
            quantityLabel.text = "\(quantity)"
        }else{
            if((Int(quantityLabel.text!) ?? 0) > 1){
                quantity -= 1
                quantityLabel.text = "\(quantity)"
            }
        }
    }
}
