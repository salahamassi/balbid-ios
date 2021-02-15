//
//  FavoriteCell.swift
//  balbid
//
//  Created by Apple on 14/02/2021.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    weak var delegate : FavoriteCellDelegate?

    var favorite: FavoriteItem? {
        didSet {
            setFavoriteData(favorite: favorite)
        }
    }

    
    private func setFavoriteData(favorite: FavoriteItem?){
        guard let favorite = favorite else {
            return
        }
        productNameLabel.text = favorite.name
        productPriceLabel.text = favorite.price + " RS"
        guard let imageUrl = URL(string: favorite.image) else {
            return
        }
        productImageView.sd_setImage(with: imageUrl)
    }
    
    @IBAction func addToCart(_ sender: Any){
        delegate?.favoriteCell(self, perform: .addToCart, with: favorite)
    }
    
    @IBAction func removeFromFavorite(_ sender: UIButton){
        sender.loadingIndicator(true)
        delegate?.favoriteCell(self, perform: .delete,  with: favorite)
    }
    
    enum ActionType {
        case addToCart, delete
    }

}


protocol FavoriteCellDelegate: class {
    func favoriteCell(_ favoriteCell: FavoriteCell, perform action: FavoriteCell.ActionType,  with favoriteItem: FavoriteItem?)
}
