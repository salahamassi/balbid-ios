//
//  AddNewShippingViewController.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit

class AddNewShippingViewController: BaseViewController {

    @IBOutlet weak var cityTextField: BorderedTextField!
    @IBOutlet weak var nameTextField: BorderedTextField!
    @IBOutlet weak var noteTextView: TextViewWithHint!
    @IBOutlet weak var countryTextField: BorderedTextField!
    @IBOutlet weak var phoneNumberTextField: BorderedTextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var neighborhoodTextField: BorderedTextField!
    @IBOutlet weak var familyTextField: BorderedTextField!
    @IBOutlet weak var regionTextField: BorderedTextField!
    @IBOutlet weak var streetTextField: BorderedTextField!
    
    var addNewShipping: ((_ address: AddressItem) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
    }

    
    private func setupNav(){
        title = "Add New Address"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupView(){
        noteTextView.contentInset = UIEdgeInsets.allSides(16)
        setData()
    }
    
    @IBAction func showMapController(_ sender: Any) {
        router?.navigate(to: .shippingMapRoute)
    }
    
    private func setData() {
        #if DEBUG
        nameTextField.text = "Qamar"
        cityTextField.text = "Gaza"
        countryTextField.text = "Palestine"
        phoneNumberTextField.text = "0569090901"
        neighborhoodTextField.text = "rawan"
        familyTextField.text = "Amassi"
        regionTextField.text = "region"
        streetTextField.text = "street"
        #endif
    }
    
    @IBAction func save(_ sender: Any) {
        saveButton.loadingIndicator(true)
        let address = AddressItem(id: -1, name: nameTextField.text!, familyName: familyTextField.text!, country: countryTextField.text!, neighborhood: neighborhoodTextField.text!, city: cityTextField.text!, mobileNumber: phoneNumberTextField.text!, region: regionTextField.text!, note: noteTextView.text!, longitude: "0,.0", latitude: "0.0", street: streetTextField.text!)
        addNewShipping?(address)
    }
}


extension AddNewShippingViewController: AddNewAddressViewModelDelegate {
    func apiError(error: String) {
        displayAlert(message: error)
    }
    
    func didAddNewAddressSuccess() {
        saveButton.loadingIndicator(false)
        router?.popViewController()
    }
    
    
}
