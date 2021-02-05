//
//  ReorderCollectionViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class ReorderCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var checkedIndexPath: [IndexPath] = []

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .reorderCellId, for: indexPath) as! ReorderCell
        cell.isChecked = checkedIndexPath.contains(indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
}
