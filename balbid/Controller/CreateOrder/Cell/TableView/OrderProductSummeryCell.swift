//
//  OrderProductSummeryCell.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit
import SDWebImage

class OrderProductSummeryCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var productNameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var brandNameLabel: UILabel!

    
    func configure(cartItem: CartItem, count: Int, index: Int) {
        setupTitleLabel(cart: cartItem, count: count, index: index)
        productNameLabel.text = cartItem.products.name
        priceLabel.text = cartItem.products.price + " SAR"
        quantityLabel.text = cartItem.quantity + " Piece"
        setupBrandLabel(cart: cartItem)
        setupQuantityLabel(cart: cartItem)
        productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        guard let imageUrl = URL(string: (cartItem.products.imageFullPath?.encodedText ?? "")) else {
            return
        }
        productImageView.sd_setImage(with: imageUrl)
    }
    
    private func setupBrandLabel(cart: CartItem){
        let mainText = "Seller: \(cart.products.brand)"
        let mutableText  = "Seller: ".convertToMutableAttributedString(with: UIFont.medium.withSize(12), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  mainText.components(separatedBy: ":")[1].convertToAttributedString(with:  UIFont.medium.withSize(12), and: #colorLiteral(red: 0.6509803922, green: 0.6509803922, blue: 0.6509803922, alpha: 1))
        mutableText.append(secondaryText)
        brandNameLabel.attributedText = mutableText
    }
    
    private func setupQuantityLabel(cart: CartItem){
        let mainText = "Quantity: \(cart.quantity) Pieces"
        let mutableText  = "Quantity: ".convertToMutableAttributedString(with: UIFont.medium.withSize(12), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  mainText.components(separatedBy: ":")[1].convertToAttributedString(with:  UIFont.medium.withSize(12), and: #colorLiteral(red: 0.6509803922, green: 0.6509803922, blue: 0.6509803922, alpha: 1))
        mutableText.append(secondaryText)
        quantityLabel.attributedText = mutableText
    }
    
    private func setupTitleLabel(cart: CartItem,count: Int, index: Int){
        let mainText = "shipment:  \(index) from  \(count)"
        let mutableText  = "shipment: ".convertToMutableAttributedString(with: UIFont.medium.withSize(12), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  mainText.components(separatedBy: ":")[1].convertToAttributedString(with:  UIFont.medium.withSize(12), and: #colorLiteral(red: 0.6509803922, green: 0.6509803922, blue: 0.6509803922, alpha: 1))
        mutableText.append(secondaryText)
        quantityLabel.attributedText = mutableText
    }
    
    

}
