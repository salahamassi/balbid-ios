//
//  AdCategoriesCollectionDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class AdCategoriesCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var openCartSheet: ((_ cell: UICollectionViewCell) -> ())?

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productCellId, for: indexPath) as! ProductCollectionViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    

    

}


extension AdCategoriesCollectionDataSource: ProductCellDelegate {
    func productCollectionViewCell(productCollectionViewCell: ProductCollectionViewCell, didSelect cell: ProductCollectionViewCell) {
        guard let openCartSheet = self.openCartSheet else {
            return
        }
        openCartSheet(cell)
    }
    
    
    
}
