//
//  AddToCartViewModel.swift
//  balbid
//
//  Created by Apple on 08/03/2021.
//

import UIKit

class AddToCartViewModel: NSObject {

    let dataSource: AppDataSource
    
    weak var delegate: AddToCartViewModelDelegate?
    
    init( dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func addToCart(productId: Int, qunatity: Int){
        dataSource.perform(service: .init(path: .addToCartPath , domain: .domain, method: .post, params: ["product_id" : productId , "quantity" : qunatity], mustUseAuth: true), ProductItem.self) { (result) in
            switch result {
            case .data(_):
                self.delegate?.didAddSuccess()
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
}


protocol AddToCartViewModelDelegate: class {
    func didAddSuccess()
    func apiError(error: String)
}
