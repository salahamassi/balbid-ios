//
//  CartTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit
import SwipeCellKit

class CartCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var delegate: SwipeActionDelegate?
    var count = 10

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .cartCellId, for: indexPath) as! SwipeCollectionViewCell
        cell.delegate  = self
        return cell
    }
}

extension CartCollectionViewDataSource: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if orientation == .right {
            let deleteAction = SwipeAction(style: .default, title: "") { action, indexPath in
                // handle action by updating model with deletion
                self.delegate?.addItemToFavorite(at: indexPath)
            }
            deleteAction.backgroundColor = UIColor.appColor(.yellowColor2)

            // customize the action appearance
            deleteAction.image = UIImage(named: .starImage)

            return [deleteAction]
        }else{
            let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in
                // handle action by updating model with deletion
                self.delegate?.deleteItem(at: indexPath)

            }
            deleteAction.backgroundColor = UIColor.appColor(.redColor2)

            // customize the action appearance
            deleteAction.image = UIImage(named: .trashImage)

            return [deleteAction]
        }
    }
}
