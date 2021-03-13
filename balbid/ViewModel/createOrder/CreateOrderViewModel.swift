//
//  CreateOrderViewModel.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit

class CreateOrderViewModel: NSObject {
    weak var delegate: CreateOrderViewModelDelegate?
    let dataSource: AppDataSource
    
     init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func addNewOrder(addressId: Int, paymentMethodId: Int) {
        dataSource.perform(service: .init(path: .addOrderPath, domain: .domain, method: .post, params: ["customer_address_id": addressId, "payment_method_id": paymentMethodId], mustUseAuth: true), Cart.self) { (result) in
            switch result {
            case .data(let  data):
                self.delegate?.didAddOrderSuccess()
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }

    
    
    
}

protocol CreateOrderViewModelDelegate: class {
    func apiError(error: String)
    func didAddOrderSuccess()
}
