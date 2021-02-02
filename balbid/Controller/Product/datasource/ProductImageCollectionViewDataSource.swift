//
//  ProductImageCollectionViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ProductImageCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productImageCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
}
