//
//  ProductDetailHeaderViewModel.swift
//  balbid
//
//  Created by Apple on 11/03/2021.
//

import UIKit

class ProductDetailHeaderViewModel: NSObject {
    
    let dataSource: AppDataSource
    
    weak var delegate: ProductDetailHeaderViewModelDelegate?
    
     init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    
    func addProductToFavorite(productId: Int, didAddToFavorite:  @escaping () -> Void){
        dataSource.perform(service: .init(path: .addToFavoritePath, domain: .domain, method: .post, params: ["product_id" : productId], mustUseAuth: true), ProductItem.self) { (result) in
            switch result {
            case .data(_):
                didAddToFavorite()
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
    func removeProductFromFavorite(productId: Int, didRemoveFromFavorite: @escaping () -> Void){
        dataSource.perform(service: .init(path: .removeFromFavoritePath + "\(productId)", domain: .domain, method: .delete, params: [:], mustUseAuth: true), ProductItem.self) { (result) in
            switch result {
            case .data(_):
                didRemoveFromFavorite()
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
}


protocol ProductDetailHeaderViewModelDelegate: class {
    func apiError(error: String)
    
}
