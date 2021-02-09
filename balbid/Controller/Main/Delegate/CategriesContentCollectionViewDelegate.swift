//
//  CategriesContentCollectionViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 09/02/2021.
//

import UIKit

class CategriesContentCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var didSelectRow: ((IndexPath) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectRow?(indexPath)
    }

}
