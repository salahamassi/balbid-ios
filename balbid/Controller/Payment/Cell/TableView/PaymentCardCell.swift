//
//  PaymentCardCell.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class PaymentCardCell: UITableViewCell {
    
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var isChecked: Bool = false {
        didSet {
            checkImageView.image = isChecked ? #imageLiteral(resourceName: "radio-on") : #imageLiteral(resourceName: "radio-off")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        cardImageView.withShadow(color: #colorLiteral(red: 0.968627451, green: 0.4196078431, blue: 0.1098039216, alpha: 1), alpha: 0.19, x: 0, y: 10, blur: 20, spread: 0)
    }

 

}
