//
//  HomeCollectionViewDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class HomeCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var delegate: HomeSelectionProtocol?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item : indexPath)
    }
    
    

}
