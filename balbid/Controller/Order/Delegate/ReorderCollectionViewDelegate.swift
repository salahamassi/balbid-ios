//
//  ReorderCollectionViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class ReorderCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var didSelectRow: ((IndexPath) -> ())?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectRow?(indexPath)
    }

}
