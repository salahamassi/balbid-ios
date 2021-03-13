//
//  PaymentMethodCell.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit
import SDWebImage

class PaymentMethodCell: UICollectionViewCell {
    
    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var paymentNameLabel: UILabel!
    @IBOutlet weak var checkedView: UIView!
    @IBOutlet weak var containerView: UIView!

    
    var paymentMethod: PaymentMethod? {
        didSet {
            setData(paymentMethod: paymentMethod)
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            checkedView.isHidden = !isChecked
            containerView.borderColor = UIColor.appColor(isChecked ? .primaryColor : .lightGrayColor) ?? .red
        }
    }
    
    
    private func setData(paymentMethod: PaymentMethod?) {
        guard let paymentMethod = paymentMethod else {
            return
        }
        paymentNameLabel.text = paymentMethod.name
        paymentImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        guard let imageUrl = URL(string: paymentMethod.image) else {
            return
        }
        paymentImageView.sd_setImage(with: imageUrl)
    }

}

