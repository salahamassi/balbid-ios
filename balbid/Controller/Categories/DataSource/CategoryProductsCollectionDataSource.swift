//
//  AdCategoriesCollectionDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CategoryProductsCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    weak var delegate: ProductCellDelegate?
    
    var product: Product?

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productCellId, for: indexPath) as! ProductCollectionViewCell
        cell.delegate = delegate
        cell.product = product?.productItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product?.productItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: .categoryProductFooterCellId , for: indexPath)
        return footer
    }
    
    

}


