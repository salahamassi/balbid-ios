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

}
