//
//  PorductDetailCollectionViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
   var headerView: ProductDetailHeaderView!    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 400)
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
//        print(contentOffsetY)
        if contentOffsetY < -40 {
            headerView?.animator?.fractionComplete = abs(contentOffsetY) / 200
        } else {
            headerView?.animator?.fractionComplete = 0.0
        }
    }
}
