//
//  ShippingAddressViewModel.swift
//  balbid
//
//  Created by Apple on 01/03/2021.
//

import UIKit

class ShippingAddressViewModel: NSObject {
    let dataSource: AppDataSource
    weak var delegate:  ShippingAddressViewModelDelegate?
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func getUserAddresses(){
        dataSource.perform(service: .init(path: .addressPath, domain: .domain, method: .get, params: [:], mustUseAuth: true), Address.self) { (result) in
            switch result {
            case .data(let data):
                self.delegate?.didLoadAddressSuccess(address: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }

}


protocol ShippingAddressViewModelDelegate: class {
    func apiError(error: String)
    func didLoadAddressSuccess(address: Address)
}
