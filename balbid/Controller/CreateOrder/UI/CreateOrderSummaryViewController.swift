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
    @IBOutlet weak var paymentMethodNameLabel: UILabel!


    var shippingAdress: AddressItem!
    var paymentMethod: PaymentMethod!
    var cart: Cart?
    private var createOrderSummaryDataSource = CreateOrderSummaryDataSource()
    weak var delegate: SizeChangableDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShippingData()
        setupPaymentMethodData()
        setupView()
    }

    private func setShippingData() {
        shippingUserNameLabel.text = shippingAdress.name + shippingAdress.familyName
        shippingCountryLabel.text = shippingAdress.country + ", "  + shippingAdress.region
        shippingCityLabel.text = shippingAdress.city + ", " + shippingAdress.neighborhood
        shippingPhoneLabel.text = shippingAdress.mobileNumber
    }
    
    private func setupPaymentMethodData() {
        paymentMethodNameLabel.text = paymentMethod.name
    }

    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        createOrderSummaryDataSource.cart = cart
        productsTableView.dataSource = createOrderSummaryDataSource
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegate?.didUpdateContentSize(newHeight: (self.view.subviews.first?.frame.height ?? .zero) + 20)
    }
}
