//
//  companyHolderInforamtionViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit

class CompanyHolderInformationViewController: BaseViewController {

    let releaseDatePicker: UIDatePicker = UIDatePicker()
    let endDatePicker: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var releaseDateTextField: BorderedTextField!
    @IBOutlet weak var endDateTextField: BorderedTextField!
    @IBOutlet weak var companyHolderNameTextField: BorderedTextField!
    @IBOutlet weak var emailTextField: BorderedTextField!
    @IBOutlet weak var passwordTextField: BorderedTextField!
    @IBOutlet weak var sourceTextField: BorderedTextField!
    @IBOutlet weak var phoneNumberTextField: BorderedTextField!
    @IBOutlet weak var civilRegistryNumberTextField: BorderedTextField!
    @IBOutlet weak var confirmPasswordTextField: BorderedTextField!
    @IBOutlet weak var errorLabel: UILabel!

    private var viewModel = CompanyHolderInformationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        setupViewModel()
        setData()
        // Do any additional setup after loading the view.
    }

    func setDatePicker() {
        releaseDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date

        releaseDateTextField.inputView = releaseDatePicker
        endDateTextField.inputView = endDatePicker
        if #available(iOS 13.4, *) {
            endDatePicker.preferredDatePickerStyle = .wheels
            releaseDatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        releaseDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }
    
    private func setData() {
        #if DEBUG
        emailTextField.text = "Qamar@gmail.com"
        phoneNumberTextField.text = "1234"
        releaseDateTextField.text = "1996-11-1"
        endDateTextField.text = "2022-11-1"
        companyHolderNameTextField.text = "Qamar Amassi"
        passwordTextField.text = "12345"
        confirmPasswordTextField.text = "12345"
        civilRegistryNumberTextField.text = "121212"
        #endif
    }

    @objc
    func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
           if let day = components.day, let month = components.month, let year = components.year {
            if sender == endDatePicker {
                endDateTextField.text = "\(day)/\(month)/\(year)"
            } else {
                releaseDateTextField.text = "\(day)/\(month)/\(year)"
            }
           }
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }

    
    func validate() -> Bool {
        errorLabel.isHidden = true
        return viewModel.validate(holderName: companyHolderNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!, civilNumber: civilRegistryNumberTextField.text!, source: sourceTextField.text!, releaseData: releaseDateTextField.text, endDate: endDateTextField.text, phoneNumber: phoneNumberTextField.text!)
    }
    
    
}


extension CompanyHolderInformationViewController: CompanyHolderInformationViewModelDelegate {
    
    func validationError(errorMessage: String, withEntry: CompanyHolderInformationViewModel.EntryType) {
        switch withEntry {
        case .email:
            emailTextField.isError = true
        case .password:
            passwordTextField.isError = true
        case .confirmPassword:
            confirmPasswordTextField.isError = true
        case .civilNumber:
            civilRegistryNumberTextField.isError = true
        case .source:
            sourceTextField.isError = true
        case .holderName:
            companyHolderNameTextField.isError = true
        case .phoneNumber:
            phoneNumberTextField.isError = true
        case .releaseDate:
            releaseDateTextField.isError = true
        case .endDate:
            endDateTextField.isError = true
        }
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    
}
