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
    }
    
    @IBAction func changeQuantity(_ sender: UIButton){
        let quantity = Int(changableQuantityLabel.text!) ?? 0
        var increasedQuantity = 0
        
        if sender.tag == 0 {
            increasedQuantity = 1
        }else{
            if(quantity >= 2){
                increasedQuantity = -1
            }
        }
        if(increasedQuantity != 0) {
            changableQuantityLabel.isHidden = true
            quantityIndicator.startAnimating()
            cartDelegate?.changeQuantity(self, to: (increasedQuantity), didComplete: { [weak self] in
                guard let self = self else {return}
                self.changableQuantityLabel.isHidden = false
                self.changableQuantityLabel.text = "\(quantity + increasedQuantity)"
                self.cart?.quantity = "\(quantity + increasedQuantity)"
                self.quantityIndicator.stopAnimating()
                if increasedQuantity == 1 {
                    self.increasePrice()
                }else {
                    self.descreasePrice()
                }
                
            })
        }
    }
    
    private func increasePrice() {
        let totalPrice = Float(cart?.totalPrice ?? "0.0") ?? 0.0
        let newTotalPrice = totalPrice + (Float(cart?.products.price ?? "0.0") ?? 0.0)
        cart?.totalPrice = "\(newTotalPrice)"
        self.productPriceLabel.text = "\(newTotalPrice)" + " SAR"
    }
    
    
    private func descreasePrice() {
        let totalPrice = Float(cart?.totalPrice ?? "0.0") ?? 0.0
        let newTotalPrice = totalPrice - (Float(cart?.products.price ?? "0.0") ?? 0.0)
        cart?.totalPrice = "\(newTotalPrice)"
        self.productPriceLabel.text = "\(newTotalPrice)" + " SAR"
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
        containerView.withShadow(color: .black, alpha: 0.1, x: 0, y: 3, blur: 14, spread: 10)
        guard let url = URL(string: cart.products.imageFullPath ?? "") else {
            return
        }
        productImageView.sd_setImage(with: url)
        
    }
}


protocol CartCollectionViewCellDelegate: class {
    func changeQuantity(_ cell: CartCollectionViewCell, to newQuantity: Int, didComplete: @escaping () ->  Void)
}
