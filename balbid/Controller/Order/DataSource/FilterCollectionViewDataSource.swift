//
//  FilterCollectionViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class FilterCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var filters: [String] = []
    var selectedIndexPath: [IndexPath] = []

    required init( filters: [String]) {
        self.filters = filters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .orderFilterCellId, for: indexPath) as! OrderFilterCollectionViewCell
        cell.filterLabel.text = filters[indexPath.row]
        cell.isToggeled = selectedIndexPath.contains(indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.count
    }

}
