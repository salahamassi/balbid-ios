//
//  FavoriteCell.swift
//  balbid
//
//  Created by Apple on 14/02/2021.
//

import UIKit
import SDWebImage

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!

    weak var delegate : FavoriteCellDelegate?

    var favorite: ProductItem? {
        didSet {
            setFavoriteData(favorite: favorite)
        }
    }

    
    private func setFavoriteData(favorite: ProductItem?){
        guard let favorite = favorite else {
            return
        }
        productNameLabel.text = favorite.name
        productPriceLabel.text = favorite.price + " RS"
        guard let imageUrl = URL(string: favorite.imageFullPath.encodedText ?? "") else {
            return
        }
        productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        productImageView.sd_setImage(with: imageUrl)
    }
    
    @IBAction func addToCart(_ sender: Any){
        delegate?.favoriteCell(self, perform: .addToCart, with: favorite)
    }
    
    @IBAction func removeFromFavorite(_ sender: UIButton){
        deleteButton.loadingIndicator(true, centerPoint: CGPoint(x: sender.frame.midX, y: sender.frame.height/2), indicatorColor: UIColor.appColor(.redColor2) ?? .gray)
        delegate?.favoriteCell(self, perform: .delete,  with: favorite)
    }
    
    func stopDeleteIndicator() {
        deleteButton.loadingIndicator(false)
    }

    
    enum ActionType {
        case addToCart, delete
    }

}


protocol FavoriteCellDelegate: class {
    func favoriteCell(_ favoriteCell: FavoriteCell, perform action: FavoriteCell.ActionType,  with favoriteItem: ProductItem?)
}
