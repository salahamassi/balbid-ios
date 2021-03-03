//
//  CompanyInformationViewModel.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class CompanyInformationViewModel: NSObject {
    
    weak var delegate: CompanyInformationViewModelDelegate?

    func validate(companyName: String,city:String,email: String,street: String,postalCode: String,phoneNumber: String,buildingNumber: String, commercialRegistrationNo: String, commercialRegistrationSource: String,commercialRegistrationEndDate: String, mnicipalLicenseNumber: String,mnicipalLicenseSource: String, mnicipalLicenseEndDate: String, activityType: String, telephoneNumber: String, faxNumber: String) -> Bool{
        var isValid = true
        if faxNumber.isEmpty {
            delegate?.validationError(errorMessage: "Invalid Fax Number",withEntry: .faxNumber)
            isValid = false
        }
        if telephoneNumber.isEmpty {
            delegate?.validationError(errorMessage: "Invalid Telephone Number",withEntry: .telephoneNumber)
            isValid = false
        }
        if phoneNumber.isEmpty {
            delegate?.validationError(errorMessage: "Invalid Phone Number",withEntry: .phoneNumber)
            isValid = false
        }
        if !email.isValidEmail() {
            delegate?.validationError(errorMessage: "Invalid Email",withEntry: .email)
            isValid = false
        }
        if activityType.isEmpty {
            delegate?.validationError(errorMessage: "Company Activity Type Must be filled",withEntry: .activityType)
            isValid = false
        }
        if mnicipalLicenseEndDate.isEmpty {
            delegate?.validationError(errorMessage: "Mnicipal License End date Must be filled",withEntry: .mnicipalLicenseEndDate)
            isValid = false
        }
        if mnicipalLicenseSource.isEmpty {
            delegate?.validationError(errorMessage: "Mnicipal License Source Must be filled",withEntry: .mnicipalLicenseSource)
            isValid = false
        }
        if mnicipalLicenseNumber.isEmpty {
            delegate?.validationError(errorMessage: "Mnicipal License Number Must be filled",withEntry: .mnicipalLicenseNumber)
            isValid = false
        }
        if commercialRegistrationEndDate.isEmpty {
            delegate?.validationError(errorMessage: "Commercial Registration End date Must be filled",withEntry: .commercialRegistrationEndDate)
            isValid = false
        }
        if commercialRegistrationSource.isEmpty {
            delegate?.validationError(errorMessage: "Commercial Registration Source code Must be filled",withEntry: .commercialRegistrationSource)
            isValid = false
        }
        if commercialRegistrationNo.isEmpty {
            delegate?.validationError(errorMessage: "Commercial Registration Number code Must be filled",withEntry: .commercialRegistrationNo)
            isValid = false
        }
        if buildingNumber.isEmpty  {
            delegate?.validationError(errorMessage: "Building Number code Must be filled",withEntry: .buildingNumber)
            isValid = false
        }
        if postalCode.isEmpty  {
            delegate?.validationError(errorMessage: "Postal code Must be filled",withEntry: .postalCode)
            isValid = false
        }
        if street.isEmpty  {
            delegate?.validationError(errorMessage: "street Must be filled",withEntry: .street)
            isValid = false
        }
        if city.isEmpty {
            delegate?.validationError(errorMessage: "City Must be filled",withEntry: .city)
            isValid = false
        }
        if companyName.isEmpty {
            delegate?.validationError(errorMessage: "Company Holder Name Must be filled",withEntry: .companyName)
            isValid = false
        }
        
        if isValid {
            MainCompanyAuthViewModel.sharedManger.params["name"] = companyName
            MainCompanyAuthViewModel.sharedManger.params["city"] = city
            MainCompanyAuthViewModel.sharedManger.params["street"] = street
            MainCompanyAuthViewModel.sharedManger.params["postal_code"] = postalCode
            MainCompanyAuthViewModel.sharedManger.params["building_number"] = buildingNumber
            MainCompanyAuthViewModel.sharedManger.params["commercial_registration_id"] = commercialRegistrationNo
            MainCompanyAuthViewModel.sharedManger.params["commercial_register_source"] = commercialRegistrationSource
            MainCompanyAuthViewModel.sharedManger.params["commercial_register_end_date"] = commercialRegistrationEndDate
            MainCompanyAuthViewModel.sharedManger.params["mail_box"] = faxNumber
            MainCompanyAuthViewModel.sharedManger.params["municipal_license_number"] = mnicipalLicenseNumber
            MainCompanyAuthViewModel.sharedManger.params["municipal_license_source"] = mnicipalLicenseSource
            MainCompanyAuthViewModel.sharedManger.params["municipal_license_end_date"] = mnicipalLicenseEndDate
            MainCompanyAuthViewModel.sharedManger.params["activity_type"] = activityType
            MainCompanyAuthViewModel.sharedManger.params["email"] = email
            MainCompanyAuthViewModel.sharedManger.params["mobile"] = phoneNumber
            MainCompanyAuthViewModel.sharedManger.params["telephone"] = telephoneNumber
        }
        
        
       return isValid
    }
    
    
    enum EntryType {
        case email, phoneNumber,companyName, city, street, postalCode, buildingNumber, commercialRegistrationNo,
             commercialRegistrationSource, commercialRegistrationEndDate, mnicipalLicenseNumber, mnicipalLicenseSource,
             mnicipalLicenseEndDate, activityType, telephoneNumber, faxNumber
    }
}


protocol CompanyInformationViewModelDelegate: class {
    func validationError(errorMessage: String, withEntry: CompanyInformationViewModel.EntryType)
}
