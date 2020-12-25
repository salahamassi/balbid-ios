//
//  LoginCountryPickerViewDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//

import UIKit
import CountryPickerView
class CustomCountryPickerViewDelegate: CountryPickerViewDelegate {
    weak var presentingDelegate: CountryPickerPresntingDelegate

    init(presentingDelegate: CountryPickerPresntingDelegate) {
        self.presentingDelegate = presentingDelegate
    }
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        presentingDelegate.didSelectCountry(country: country)
    }

}
