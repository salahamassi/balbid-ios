//
//  AddNewAddressViewModel.swift
//  balbid
//
//  Created by Apple on 11/03/2021.
//

import UIKit

class AddNewAddressViewModel: NSObject {
    
    let dataSource: AppDataSource
    weak var delegate: AddNewAddressViewModelDelegate?
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    
    func addNewAddress(address: AddressItem) {
        dataSource.perform(service: .init(path: .addNewAddressPath, domain: .domain, method: .post, params: ["name": address.name, "family_name": address.familyName, "neighborhood": address.neighborhood, "city": address.city, "region": address.region, "street_number": address.street, "mobile": address.mobileNumber, "note": address.note, "country": address.country, "longitude": address.longitude, "latitude": address.latitude], mustUseAuth: true), Address.self) { (result) in
            switch result {
            case .data(_):
                self.delegate?.didAddNewAddressSuccess()
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
}


protocol AddNewAddressViewModelDelegate: class {
    func apiError(error: String)
    func didAddNewAddressSuccess()
}
