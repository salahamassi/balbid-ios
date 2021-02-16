//
//  AdCategoriesViewModel.swift
//  balbid
//
//  Created by Apple on 13/02/2021.
//

import UIKit

struct CategoryProductsViewModel {
    
    let dataSource: AppDataSource
    weak var delegate: AdCategoriesViewModelDelegate?
    
    init(dataSource: AppDataSource) {
        self.dataSource =  dataSource
    }
    
    func getProductCategory(from categoryId: Int) {
        dataSource.perform(service: .init(path: .categoryProductPath  + "\(categoryId)&paginate=5&page=1&order_by=price&sort_direction=ASC", domain: .domain, method: .get, params: [:], mustUseAuth: true), Product.self) { (result) in
            switch result {
            case .data(let data):
                self.delegate?.loadProductSuccess(product: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
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
protocol AdCategoriesViewModelDelegate: class {
    func apiError(error: String)
    func loadProductSuccess(product: Product)
}
