//
//  AddNewShippingViewController.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit

class AddNewShippingViewController: BaseViewController {

    @IBOutlet weak var errorLabel: UILabel!
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
    var err: String? = nil
    private var latitude = 0.0
    private var longitude = 0.0

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
        router?.navigate(to: ShippingRoutes.shippingMapRoute(delegate: self))
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
    
    private func validate() {
        err = nil
        validateNotEmptyTextField(textField: nameTextField, message: "Name must be filled")
        validateNotEmptyTextField(textField: familyTextField, message: "Family Name must be filled")
        validateNotEmptyTextField(textField: countryTextField, message: "Country must be filled")
        validateNotEmptyTextField(textField: neighborhoodTextField, message: "Neighborhood must be filled")
        validateNotEmptyTextField(textField: cityTextField, message: "City must be filled")
        validateNotEmptyTextField(textField: phoneNumberTextField, message: "Invalid Phone Number")
        validateNotEmptyTextField(textField: regionTextField, message: "Region must be filled")
        validateNotEmptyTextField(textField: streetTextField, message: "Street must be filled")

    }
    
    private func validateNotEmptyTextField(textField: BorderedTextField, message: String) {
        if(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true) {
            textField.isError = true
            err = message
        }
    }
    
    private func sendRequest() {
        errorLabel.isHidden = true
        saveButton.loadingIndicator(true)
        let address = AddressItem(id: -1, name: nameTextField.text!, familyName: familyTextField.text!, country: countryTextField.text!, neighborhood: neighborhoodTextField.text!, city: cityTextField.text!, mobileNumber: phoneNumberTextField.text!, region: regionTextField.text!, note: noteTextView.text!, longitude: "\(longitude)", latitude: "\(latitude)", street: streetTextField.text!)
        addNewShipping?(address)
    }
    
    @IBAction func save(_ sender: Any) {
        validate()
        if (err == nil)  {
            sendRequest()
        }else {
            errorLabel.isHidden = false
            errorLabel.text = err
        }
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

extension AddNewShippingViewController: ShippingMapViewControllerDelegate {
    func didSelectLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
}
