//
//  SizeSelectionDelegate.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SizeSelectionDelegate: NSObject, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    var didSelectRow: ((_ row: Int) -> Void)?

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         didSelectRow?(indexPath.row)
    }
     
}
