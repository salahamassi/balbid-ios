//
//  HomeSliderCell.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import UIKit

class HomeSliderCell: UICollectionViewCell {
    
    @IBOutlet weak var slierImageView: UIImageView!
    
    var sliderImage: SliderImage? {
        didSet {
            guard let imageUrl = URL(string: sliderImage?.image ?? "") else {
                return
            }
            slierImageView.sd_setImage(with: imageUrl)
        }
    }
}
