//
//  CategoryContentHeaderCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CategoryContentHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    
    var isExpanded: Bool = false {
        didSet {
            arrowImageView.image = UIImage(named: isExpanded ? .arrowUpImage : .arrowDownImage)
        }
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        arrowImageView.image = UIImage(named: isExpanded ? .arrowUpImage : .arrowDownImage)
    }
}
