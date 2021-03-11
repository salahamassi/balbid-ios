//
//  CartTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import SwipeCellKit

class CartCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    weak var delegate: SwipeActionDelegate?
    var cart: Cart?
    weak var cartDelegate: CartCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cart?.cartItem.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .cartCellId, for: indexPath) as! CartCollectionViewCell
        cell.cart = cart?.cartItem[indexPath.row]
        cell.delegate  = self
        cell.cartDelegate = cartDelegate
        return cell
    }
}

extension CartCollectionViewDataSource: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .right {
            guard let product = cart?.cartItem[indexPath.row].products else {
                return []
            }
            let addToFavoriteAction = SwipeAction(style: .default, title: "") { action, indexPath in
                // handle action by updating model with deletion
                self.delegate?.addItemToFavorite(at: indexPath)
            }
            addToFavoriteAction.backgroundColor = UIColor.appColor(.yellowColor2)
           
            // customize the action appearance
            
//            addToFavoriteAction.image =  (product.isFavorite ?? "0" == "0") ?  #imageLiteral(resourceName: "empty-rating-star") : #imageLiteral(resourceName: "star")
            if #available(iOS 13.0, *) {
                addToFavoriteAction.image = (product.isFavorite ?? "0" == "0") ? #imageLiteral(resourceName: "empty-star").sd_resizedImage(with: .init(width: 25, height: 25), scaleMode: .aspectFit)?.withTintColor(.white) : #imageLiteral(resourceName: "star")
            } else {
                addToFavoriteAction.image = (product.isFavorite ?? "0" == "0") ? #imageLiteral(resourceName: "empty-star").sd_resizedImage(with: .init(width: 25, height: 25), scaleMode: .aspectFit) : #imageLiteral(resourceName: "star")
            }


            return [addToFavoriteAction]
        }else{
            let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in
                // handle action by updating model with deletion
                
                self.delegate?.deleteItem(at: indexPath)
                action.fulfill(with: .delete)
            }
            deleteAction.backgroundColor = UIColor.appColor(.redColor2)

            // customize the action appearance
            deleteAction.image = UIImage(named: .trashImage)

            return [deleteAction]
        }
    }
}
