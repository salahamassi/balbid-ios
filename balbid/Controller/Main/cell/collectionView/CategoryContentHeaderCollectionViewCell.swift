//
//  CategoryContentHeaderCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CategoryContentHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    
    var isExpanded: Bool = false {
        didSet {
            arrowImageView.image = UIImage(named: isExpanded ? .arrowUpImage : .arrowDownImage)
        }
    }
    
    var categoryItem: CategoryItem? {
        didSet {
            nameLabel.text = categoryItem?.name
        }
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        arrowImageView.image = UIImage(named: isExpanded ? .arrowUpImage : .arrowDownImage)
    }
}
