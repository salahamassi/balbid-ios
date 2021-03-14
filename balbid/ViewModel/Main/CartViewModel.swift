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
            case .failure(_):
                self.delegate?.emptyCart()
            default:
                break
            }
        }
    }
    
    
    func deleteFromCart(id: Int,index: Int) {
        appDataSource.perform(service: .init(path: .deleteFromCartPath + "\(id)", domain: .domain, method: .delete, params: [:], mustUseAuth: true), Cart.self) { (result) in
            switch result {
            case .data(_):
                self.delegate?.didDeleteSuccessfully(index: index)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
    func updateProductQuantity(id: Int,quantity: Int, index: Int, didUpdateQuantity: @escaping () -> Void) {
        appDataSource.perform(service: .init(path: .updateShoppingCart , domain: .domain, method: .post, params: ["product_cart_id": id, "quantity": quantity], mustUseAuth: true), Cart.self) { (result) in
            switch result {
            case .data(_):
                didUpdateQuantity()
                self.delegate?.didUpdateQuantity(quantity: quantity, index: index)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
    func addProductToFavorite(productId: Int){
        appDataSource.perform(service: .init(path: .addToFavoritePath, domain: .domain, method: .post, params: ["product_id" : productId], mustUseAuth: true), ProductItem.self) { (result) in
            switch result {
            case .data(_):
                self.delegate?.didAddToFavoriteSuccess()
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
    func removeProductFromFavorite(productId: Int){
        appDataSource.perform(service: .init(path: .removeFromFavoritePath + "\(productId)", domain: .domain, method: .delete, params: [:], mustUseAuth: true), ProductItem.self) { (result) in
            switch result {
            case .data(_):
                self.delegate?.didRemoveFromFavoriteSuccess()
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
    func didDeleteSuccessfully(index: Int)
    func didUpdateQuantity(quantity: Int,  index: Int)
    func apiError(error: String)
    func didAddToFavoriteSuccess()
    func didRemoveFromFavoriteSuccess()
    func emptyCart()

}
