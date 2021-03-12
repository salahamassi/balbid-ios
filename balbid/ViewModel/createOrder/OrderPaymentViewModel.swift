//
//  OrderPaymentViewModel.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit

class OrderPaymentViewModel: NSObject {
    
    weak var delegate: OrderPaymentViewModelDelegate?
    let dataSource: AppDataSource
    
     init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    
    func getPaymentMethod() {
        dataSource.perform(service: .init(path: .systemConstantPath, domain: .domain, method: .get, params: [:], mustUseAuth: true), SystemConstant.self) { (result) in
            switch result {
            case .data(let  data):
                self.delegate?.didLoadPaymentMethodSuccess(paymentMethods: data.data.paymentMethods)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }

}

protocol OrderPaymentViewModelDelegate: class {
    func apiError(error: String)
    func didLoadPaymentMethodSuccess(paymentMethods: [PaymentMethod])
}
