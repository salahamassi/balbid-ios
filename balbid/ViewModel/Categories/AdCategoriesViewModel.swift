//
//  AdCategoriesViewModel.swift
//  balbid
//
//  Created by Apple on 13/02/2021.
//

import UIKit

struct AdCategoriesViewModel {
    
    let dataSource = AppDataSource()
    
    func addProductToFavorite(productId: Int){
        dataSource.perform(service: .init(path: .addToFavoritePath, domain: .domain, method: .post, params: ["product_id" : productId], mustUseAuth: true), Product.self) { (result) in
            switch result {
            case .success(let data):
                 print(data)
            case .failure(let error):
                 print(error)
            default:
                break
        }
    }
  }

}
protocol AdCategoriesViewModelDelegate {
    
    
}
