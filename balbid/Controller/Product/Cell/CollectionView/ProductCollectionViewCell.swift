//
//  ProductCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 30/12/2020.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addToCartButton: UIButton!
    var delegate : ProductCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addToCartButton.withCornerRadius(10, corners: [.bottomLeft,.bottomRight])
    }
    
    
    @IBAction func addToCart(_ sender: Any){
        
        delegate?.productCollectionViewCell(productCollectionViewCell: self, didSelect: self)
    }
}
