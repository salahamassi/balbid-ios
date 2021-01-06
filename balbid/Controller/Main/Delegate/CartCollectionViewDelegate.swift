//
//  CartTableViewCellDellegate.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CartCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate: SwipeActionDelegate?

    
//
//    func collectionView(_ collectionView: UICollectionView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal, title: "") {[weak self] (_, _, _) in
//            self?.delegate?.deleteItem(at: indexPath)
//        }
//        action.image = UIImage(named:.trashImage)
//        action.backgroundColor = UIColor.appColor(.redColor2)
//        return UISwipeActionsConfiguration(actions: [action])
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal, title: "") {[weak self] (_, _, _) in
//            self?.delegate?.addItemToFavorite(at: indexPath)
//        }
//        action.image = UIImage(named:.starImage)
//        action.backgroundColor = UIColor.appColor(.yellowColor2)
//        return UISwipeActionsConfiguration(actions: [action])
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}
