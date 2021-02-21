//
//  ProductImageCollectionViewDelegate.swift
//  balbid
//
//  Created by Apple on 21/02/2021.
//

import UIKit

class ProductImageCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    var didScroll: ((_ index: Int) -> Void)?
    let collectionView: UICollectionView
    
     init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = collectionView.contentOffset.x / collectionView.frame.size.width
        didScroll?(Int(currentIndex))
    }

   
}
