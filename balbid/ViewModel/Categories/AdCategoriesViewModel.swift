//
//  AdCategoriesViewModel.swift
//  balbid
//
//  Created by Apple on 13/02/2021.
//

import UIKit

class CategoryProductsViewModel {
    
    let dataSource: AppDataSource
    weak var delegate: AdCategoriesViewModelDelegate?
    var pageNumber = 0
    
    init(dataSource: AppDataSource) {
        self.dataSource =  dataSource
    }
    
    func getProductCategory(from categoryId: Int,isPaging: Bool) {
        if(isPaging) {
            pageNumber = pageNumber + 1
        }
        dataSource.perform(service: .init(path: .categoryProductPath  + "\(categoryId)&paginate=4&page=\(pageNumber)&order_by=price&sort_direction=ASC", domain: .domain, method: .get, params: [:], mustUseAuth: true), Product.self) { (result) in
            switch result {
            case .data(let data):
                if isPaging {
                   self.delegate?.didLoadNewPaginate(product: data.data)
                }else {
                    self.delegate?.loadProductSuccess(product: data.data)
                }
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
    func didLoadNewPaginate(product: Product)

}
