//
//  ShippingAddressCell.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ShippingAddressCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: UIButton!

    var isChecked: Bool = false {
        didSet{
            radioButton.setImage(isChecked ? #imageLiteral(resourceName: "radio-on") : #imageLiteral(resourceName: "radio-off"), for: .normal)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isChecked = false
    }
}
