//
//  FavoriteViewModel.swift
//  balbid
//
//  Created by Apple on 14/02/2021.
//

import UIKit

class FavoriteViewModel: NSObject {

    let dataSource: AppDataSource
    weak var delegate: FavoriteViewModelDelegate?
    
    
    init( dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    
    func loadFavorite() {
        dataSource.perform(service: .init(path: .favoritePath, domain: .domain, method: .get, params: [:]), Favorite.self) { (result) in
            switch result {
              case .data(let data):
                self.delegate?.loadFavoriteSuccess(favorite: data.data)
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


protocol FavoriteViewModelDelegate: class {
    func apiError(error: String)
    func loadFavoriteSuccess(favorite: Favorite)
}
