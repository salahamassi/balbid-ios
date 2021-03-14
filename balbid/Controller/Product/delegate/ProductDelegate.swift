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
    var showLoginAlert: (() -> Void)?

    var collectionView:  UICollectionView!
    
    
    func productCollectionViewCell(_ productCollectionViewCell: ProductCollectionViewCell, perform action: ProductCollectionViewCell.ActionType, with product: ProductItem?) {
        guard  let product = product else {
            return
        }
        guard UserDefaultsManager.token != nil else {
            showLoginAlert?()
            productCollectionViewCell.stopIndicator()
            return
        }
        switch action {
        case .addToCart:
            showAddToCartView?(productCollectionViewCell)
        case .favorite:
            if product.isFavorite == "1" {
                deleteFavorite?(product.id) { [weak self] in
                    guard let indexPath =  self?.collectionView.indexPath(for: productCollectionViewCell) else {
                        return
                    }
                    NotificationCenter.default.post(.init(name: .didRemoveFromFavorite, object:nil, userInfo:  ["indexPath":indexPath,"product":product] ))

                    productCollectionViewCell.removeFromFavorite()
                }
            }else{
                addToFavorite?(product.id, { [weak self] in
                    guard let indexPath =  self?.collectionView.indexPath(for: productCollectionViewCell) else {
                        return
                    }
                    NotificationCenter.default.post(.init(name: .didAddToFavorite, object:nil, userInfo:  ["indexPath":indexPath,"product":product] ))
                    productCollectionViewCell.addToFavorite()
                })
            }
        }
        
    }
    
   
}
