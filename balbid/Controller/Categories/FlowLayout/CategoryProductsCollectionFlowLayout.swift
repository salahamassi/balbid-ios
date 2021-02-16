//
//  AdCategoriesCollectionFlowLayout.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CategoryProductsCollectionFlowLayout: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var showProductDetail: ((_ row: Int) -> ())?

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 16, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let  showProductDetail = showProductDetail else{
            return
        }
        showProductDetail(indexPath.row)
    }
}

