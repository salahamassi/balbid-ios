//
//  ShippingAddressCell.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ShippingAddressCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    var isChecked: Bool = false {
        didSet{
            radioButton.setImage(isChecked ? #imageLiteral(resourceName: "radio-on") : #imageLiteral(resourceName: "radio-off"), for: .normal)
        }
    }
    
    var address: AddressItem? {
        didSet {
            setAddressData(address: address)
        }
    }
    
    private func setAddressData(address: AddressItem?) {
        guard let address = address else {
            return
        }
        userNameLabel.text = address.name + address.familyName
        countryLabel.text = address.country + ", "  + address.region
        cityLabel.text = address.city + ", " + address.neighborhood
        phoneLabel.text = address.mobileNumber
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isChecked = false
    }
}
