//
//  ProductCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 30/12/2020.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productDiscountPriceView: UIView!
    @IBOutlet weak var productDiscountPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    var delegate : ProductCellDelegate?
    
    
    var product: Product? {
        didSet {
            setProductData(product: product)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addToCartButton.withCornerRadius(10, corners: [.bottomLeft,.bottomRight])
    }
    
    @IBAction func addToCart(_ sender: Any){
        delegate?.productCollectionViewCell(self, perform: .addToCart, with: product)
    }
    
    @IBAction func addToFavorite(_ sender: UIButton){
        sender.loadingIndicator(true, centerPoint: CGPoint(x: favoriteButton.frame.origin.x, y: favoriteButton.frame.midY), indicatorColor: UIColor.appColor(.primaryColor) ?? .gray)
        delegate?.productCollectionViewCell(self, perform: .favorite,  with: product)
    }
    
    func addToFavorite(){
        favoriteButton.loadingIndicator(false)
        favoriteButton.animateImageChange(#imageLiteral(resourceName: "selected_favorite"))
        product?.isFavorite = "1"
    }
    
    func removeFromFavorite(){
        favoriteButton.loadingIndicator(false)
        favoriteButton.animateImageChange(#imageLiteral(resourceName: "unselected_favorite"))
        product?.isFavorite = "0"
    }
    
    private func setProductData(product: Product?){
//        if let discount = product?.discount {
//            productDiscountPriceLabel.text = discount + "% OFF"
//        }else{
            productDiscountPriceView.isHidden = true
            productDiscountPriceLabel.isHidden = true
            offerLabel.isHidden = true
//        }
        favoriteButton.setImage(product?.isFavorite == "0" ? #imageLiteral(resourceName: "unselected_favorite") : #imageLiteral(resourceName: "selected_favorite") , for: .normal)
        productNameLabel.text = product?.name
        productPriceLabel.text = (product?.price ?? "0") + " SR"
        guard let imageUrl = URL(string: product?.image ?? "") else {
            return
        }
        productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        productImageView.sd_setImage(with: imageUrl)

    }
    
    enum ActionType {
        case addToCart, favorite
    }
    
}
