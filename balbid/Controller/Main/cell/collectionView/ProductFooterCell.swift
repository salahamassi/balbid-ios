//
//  ProductFooterCell.swift
//  balbid
//
//  Created by Memo Amassi on 09/02/2021.
//

import UIKit
import SDWebImage

class ProductFooterCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    var banner: Banner?{
        didSet {
            guard let imageUrl = URL(string: banner?.image ?? "") else {
                return
            }
            bannerImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            bannerImageView.sd_setImage(with: imageUrl)
        }
        
        
    }
    
    
}
