//
//  CreateOrderSummaryViewController.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit

class CreateOrderSummaryViewController: BaseViewController {
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var shippingUserNameLabel: UILabel!
    @IBOutlet weak var shippingCountryLabel: UILabel!
    @IBOutlet weak var shippingCityLabel: UILabel!
    @IBOutlet weak var shippingPhoneLabel: UILabel!
    

    var shippingAdress: AddressItem!
    var paymentMethod: PaymentMethod!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setShippingData()
    }
    

    private func setShippingData() {
        shippingUserNameLabel.text = shippingAdress.name + shippingAdress.familyName
        shippingCountryLabel.text = shippingAdress.country + ", "  + shippingAdress.region
        shippingCityLabel.text = shippingAdress.city + ", " + shippingAdress.neighborhood
        shippingPhoneLabel.text = shippingAdress.mobileNumber
    }

}
