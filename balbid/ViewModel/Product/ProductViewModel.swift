//
//  ProductViewModel.swift
//  balbid
//
//  Created by Apple on 19/02/2021.
//

import UIKit

class ProductViewModel: NSObject {
    
    let dataSource: AppDataSource
    weak var delegate:  ProductViewModelDelegate?
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func getProductData(id: Int){
        dataSource.perform(service: .init(path: .productDetailPath + "\(id)", domain: .domain, method: .get, params: [:], mustUseAuth: true), ProductItem.self) { (result) in
            switch result {
            case .data(let data):
                self.delegate?.didLoadProductSuccess(product: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
}

protocol ProductViewModelDelegate: class {
    func apiError(error: String)
    func didLoadProductSuccess(product: ProductItem)

}
