//
//  CartTableViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!

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
