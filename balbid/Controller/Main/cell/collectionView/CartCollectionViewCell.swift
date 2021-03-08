//
//  CartTableViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import SwipeCellKit
import SDWebImage
class CartCollectionViewCell: SwipeCollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var changableQuantityLabel: UILabel!
    weak var cartDelegate: CartCollectionViewCellDelegate?

    var cart: CartItem? {
        didSet {
            setupCartData(cart: cart)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.withShadow(color: .black, alpha: 0.1, x: 0, y: 3, blur: 14, spread: 0)
    }

    @IBAction func changeQuantity(_ sender: UIButton){
        var quantity = Int(changableQuantityLabel.text!) ?? 0
        if sender.tag == 0 {
            quantity += 1
        }else{
            if((Int(quantityLabel.text!) ?? 0) > 1){
                quantity -= 1
            }
        }
        changableQuantityLabel.isHidden = true
        quantityIndicator.startAnimating()
        cartDelegate?.changeQuantity(self, to: quantity, didComplete: { [weak self] in
            guard let self = self else {return}
            self.changableQuantityLabel.isHidden = false
            self.changableQuantityLabel.text = "\(quantity)"
            self.quantityIndicator.stopAnimating()
        })
    }
    
    private func setupCartData(cart: CartItem?) {
        guard let cart = cart else {
            return
        }
        quantityLabel.text = cart.quantity + " Piece"
        productPriceLabel.text = cart.totalPrice + " SAR"
        productNameLabel.text = cart.products.name
        productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        changableQuantityLabel.text = cart.quantity
        guard let url = URL(string: cart.products.imageFullPath ?? "") else {
            return
        }
        productImageView.sd_setImage(with: url)
        
    }
}


protocol CartCollectionViewCellDelegate: class {
    func changeQuantity(_ cell: CartCollectionViewCell, to newQuantity: Int, didComplete: @escaping () ->  Void)
}
