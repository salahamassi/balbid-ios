//
//  ProductCellDelegate.swift
//  balbid
//
//  Created by Apple on 19/02/2021.
//

import UIKit

class ProductDelegate: NSObject, ProductCellDelegate {
    
    var deleteFavorite: ((_ id: Int,_ didRemoveFromFavorite: @escaping ()->Void) -> Void)?
    var addToFavorite: ((_ id: Int,_ didAddToFavorite: @escaping ()->Void) -> Void)?
    var showAddToCartView: ((_ cell: ProductCollectionViewCell) -> Void)?
    
    
    func productCollectionViewCell(_ productCollectionViewCell: ProductCollectionViewCell, perform action: ProductCollectionViewCell.ActionType, with product: ProductItem?) {
        guard  let product = product else {
            return
        }
        switch action {
        case .addToCart:
            showAddToCartView?(productCollectionViewCell)
        case .favorite:
            if product.isFavorite == "1" {
                deleteFavorite?(product.id) {
                    productCollectionViewCell.removeFromFavorite()
                }
            }else{
                addToFavorite?(product.id, {
                    productCollectionViewCell.addToFavorite()
                })
            }
        }
        
    }
    
   
}
