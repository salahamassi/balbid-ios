//
//  ProductDetailCollectionViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
   
    var assignViewHeader: ((ProductDetailHeaderView) -> ())?
    
    weak var productDetailCellDelegate: ProductDetailCollectionViewCellDelegate?
    weak var productDetailHeaderCollectionReusableViewDelegate: ProductDetailHeaderCollectionReusableViewDelegate?
    var product: ProductItem?

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productDetailCellId, for: indexPath)  as! ProductDetailCollectionViewCell
        cell.delegate = productDetailCellDelegate
        cell.product = product
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: .productDetailHeaderCellId, for: indexPath) as! ProductDetailHeaderView
        assignViewHeader?(headerView)
        headerView.delegate = productDetailHeaderCollectionReusableViewDelegate
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

}
