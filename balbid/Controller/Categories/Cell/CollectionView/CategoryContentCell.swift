//
//  CategoryContentCell.swift
//  balbid
//
//  Created by Apple on 16/02/2021.
//

import UIKit
import SDWebImage

class CategoryContentCell: UICollectionViewCell {
    
    @IBOutlet weak var  categoryImageView: UIImageView!
    @IBOutlet weak var  categoryNameLabel: UILabel!
    
    var categoryItem: CategoryItem? {
        didSet {
            setCategoryData(categoryItem: categoryItem)
        }
    }
    
    private func setCategoryData(categoryItem: CategoryItem?) {
        guard let categoryItem =  categoryItem  else {
            return
        }
        categoryNameLabel.text =  categoryItem.name
        guard let imageUrl = URL(string: categoryItem.image.encodedText ?? "") else {
            return
        }
        categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        categoryImageView.sd_setImage(with: imageUrl)
        
    }

}
