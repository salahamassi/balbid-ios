//
//  IdentityConfirmViewModel.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import UIKit

class IdentityConfirmViewModel: NSObject {

    
    func addField(identityImage: String, commerciaRegistrationImage: String, municipalityLicenseImage: String) {
        MainCompanyAuthViewModel.sharedManger.params["national_identity_image"] = identityImage
        MainCompanyAuthViewModel.sharedManger.params["commercial_registration_image"] = commerciaRegistrationImage
        MainCompanyAuthViewModel.sharedManger.params["municipal_license_image"] = municipalityLicenseImage
    }
}

