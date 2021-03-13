//
//  PaymentMethodDelegate.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit

class PaymentMethodDelegate: NSObject,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var didSelectRow: ((_ at: Int) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 82, height: 66)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectRow?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
}
