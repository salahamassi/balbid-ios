//
//  HomeSliderCell.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import UIKit
import SDWebImage

class ImageSliderCell: UICollectionViewCell {
    
    @IBOutlet weak var slierImageView: UIImageView!
    
    var sliderImage: String? {
        didSet {
            slierImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            guard let imageUrl = URL(string: sliderImage?.encodedText ?? "") else {
                return
            }
            slierImageView.sd_setImage(with: imageUrl)
        }
    }
}
