//
//  OrderTableViewCell.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!

    
    override  func awakeFromNib() {
        containerView.withShadow(color: .black, alpha: 0.05, x: 0, y: 5, blur: 15, spread: 0)
    }
    

}
