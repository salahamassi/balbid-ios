//
//  CompanyInfromationViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit

class CompanyInformationViewController: BaseViewController {
    
    private var viewModel = CompanyInformationViewModel()
    @IBOutlet weak var cityTextField: BorderedTextField!
    @IBOutlet weak var companyNameTextField: BorderedTextField!
    @IBOutlet weak var streetTextField: BorderedTextField!
    @IBOutlet weak var postalCodeTextField: BorderedTextField!
    @IBOutlet weak var commercialRegistrationNumberTextField: BorderedTextField!
    @IBOutlet weak var commercialRegistrationSourceTextField: BorderedTextField!
    @IBOutlet weak var commercialRegistrationEndDateTextField: BorderedTextField!
    @IBOutlet weak var municipalLicenseNumberTextField: BorderedTextField!
    @IBOutlet weak var municipalLicenseSourceTextField: BorderedTextField!
    @IBOutlet weak var municipalLicenseEndDateTextField: BorderedTextField!
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var mobileNumberTextField: BorderedTextField!
    @IBOutlet weak var faxNumberTextField: BorderedTextField!
    @IBOutlet weak var telephoneNumberTextField: BorderedTextField!
    @IBOutlet weak var buisnessTypeTextField: BorderedTextField!
    @IBOutlet weak var buildingNumberTextField: BorderedTextField!
    @IBOutlet weak var errorLabel: UILabel!
    private let commercialRegistrationEndDatePicker: UIDatePicker = UIDatePicker()
    private let municipalLicenseEndDatePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setDatePicker()

        // Do any additional setup after loading the view.
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    func setDatePicker() {
        commercialRegistrationEndDatePicker.datePickerMode = .date
        municipalLicenseEndDatePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            municipalLicenseEndDatePicker.preferredDatePickerStyle = .wheels
            commercialRegistrationEndDatePicker.preferredDatePickerStyle = .wheels

        } else {
            // Fallback on earlier versions
        }

        commercialRegistrationEndDateTextField.inputView = commercialRegistrationEndDatePicker
        municipalLicenseEndDateTextField.inputView = municipalLicenseEndDatePicker

        commercialRegistrationEndDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        municipalLicenseEndDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }
    
    @objc
    func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
           if let day = components.day, let month = components.month, let year = components.year {
            if sender == commercialRegistrationEndDatePicker {
                commercialRegistrationEndDateTextField.text = "\(day)/\(month)/\(year)"
            } else {
                municipalLicenseEndDateTextField.text = "\(day)/\(month)/\(year)"
            }
           }
    }
    
    func validate() -> Bool {
        errorLabel.isHidden = true
        return viewModel.validate(companyName: companyNameTextField.text!, city: cityTextField.text!, email: emailTextField.text!, street: streetTextField.text!, postalCode: postalCodeTextField.text!, phoneNumber: mobileNumberTextField.text!, buildingNumber: buildingNumberTextField.text!, commercialRegistrationNo: commercialRegistrationNumberTextField.text!, commercialRegistrationSource: commercialRegistrationSourceTextField.text!, commercialRegistrationEndDate: commercialRegistrationEndDateTextField.text!, mnicipalLicenseNumber: municipalLicenseNumberTextField.text!, mnicipalLicenseSource: municipalLicenseSourceTextField.text!, mnicipalLicenseEndDate: municipalLicenseEndDateTextField.text!, activityType:buisnessTypeTextField.text!, telephoneNumber: telephoneNumberTextField.text!, faxNumber: faxNumberTextField.text!)
    }
    

}

extension CompanyInformationViewController: CompanyInformationViewModelDelegate {
    func validationError(errorMessage: String, withEntry: CompanyInformationViewModel.EntryType) {
        switch withEntry {
        case .activityType:
            buisnessTypeTextField.isError = true
        case .buildingNumber:
            buildingNumberTextField.isError = true
        case .city:
            cityTextField.isError = true
        case .commercialRegistrationNo:
            commercialRegistrationNumberTextField.isError = true
        case .commercialRegistrationSource:
            commercialRegistrationSourceTextField.isError = true
        case .commercialRegistrationEndDate:
            commercialRegistrationEndDateTextField.isError = true
        case .companyName:
            companyNameTextField.isError = true
        case .email:
            emailTextField.isError = true
        case .faxNumber:
            faxNumberTextField.isError = true
        case .mnicipalLicenseEndDate:
            municipalLicenseEndDateTextField.isError = true
        case .mnicipalLicenseNumber:
            municipalLicenseNumberTextField.isError = true
        case .mnicipalLicenseSource:
            municipalLicenseSourceTextField.isError = true
        case .phoneNumber:
            mobileNumberTextField.isError = true
        case .postalCode:
            postalCodeTextField.isError = true
        case .street:
            streetTextField.isError = true
        case .telephoneNumber:
            telephoneNumberTextField.isError = true
        }
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
        
    }
    
    
}
