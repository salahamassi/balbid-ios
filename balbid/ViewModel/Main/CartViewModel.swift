//
//  CartViewModel.swift
//  balbid
//
//  Created by Apple on 08/03/2021.
//

import UIKit

class CartViewModel: NSObject {
    
    let appDataSource: AppDataSource
    weak var delegate: CartViewModelDelegate?
    
    init(appDataSource: AppDataSource) {
        self.appDataSource = appDataSource
    }
    
    func getCartData(){
        appDataSource.perform(service: .init(path: .cartPath, domain: .domain, method: .get, params: [:], mustUseAuth: true), Cart.self) { (result) in
            switch result {
            case .data(let data):
                self.delegate?.loadCartSuccess(cart: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
}


protocol CartViewModelDelegate: class {
    func loadCartSuccess(cart: Cart)
    func apiError(error: String)
}
