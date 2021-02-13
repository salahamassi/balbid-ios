//
//  AdCategoriesCollectionDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class AdCategoriesCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    weak var delegate: ProductCellDelegate?

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productCellId, for: indexPath) as! ProductCollectionViewCell
        
        cell.delegate = delegate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    

    

}


