//
//  HomeViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import UIKit

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    let dataSource: AppDataSource
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func getHomeData(){
        dataSource.perform(service: .init(path: .homePath, domain: .domain, method: .get, params: [:]), Home.self) { (result) in
            switch result {
              case .data(let data):
                self.delegate?.loadHomeSuccess(home: data.data)
              case .failure(let error):
                self.delegate?.apiError(error: error)
              default:
                break
            }
        }
    }
    
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


protocol HomeViewModelDelegate: class {
    func loadHomeSuccess(home: Home)
    func apiError(error: String)

}
