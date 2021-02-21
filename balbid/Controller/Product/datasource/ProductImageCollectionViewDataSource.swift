//
//  ProductImageCollectionViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ProductImageCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var images:  [String] = []
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productImageCellId, for: indexPath)  as!  ImageSliderCell
        cell.sliderImage = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
}
