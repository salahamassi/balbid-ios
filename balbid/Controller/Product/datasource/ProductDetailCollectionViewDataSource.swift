//
//  PorductDetailCollectionViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
   
    var assignViewHeader: ((ProductDetailHeaderCollectionReusableView) -> ())?
    
    weak var productDetailCellDelegate: ProductDetailCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productDetailCellId, for: indexPath)
        (cell as? ProductDetailCollectionViewCell)?.delegate = productDetailCellDelegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: .topKind, withReuseIdentifier: .productDetailHeaderCellId, for: indexPath) as! ProductDetailHeaderCollectionReusableView
        assignViewHeader?(headerView)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

}
