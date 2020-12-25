//
//  CountryPickerPresntingDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 17/12/2020.
//
import CountryPickerView
protocol  CountryPickerPresntingDelegate: class {
    func didSelectCountry(country: Country)
}
