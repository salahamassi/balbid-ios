//
//  CateogryCell.swift
//  balbid
//
//  Created by Apple on 16/02/2021.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var category: CategoryItem? {
        didSet {
            nameLabel.text = category?.name ?? ""
        }
    }

}
