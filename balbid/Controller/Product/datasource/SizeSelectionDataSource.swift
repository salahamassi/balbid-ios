//
//  SizeSelectionDataSource.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SizeSelectionDataSource: NSObject, UICollectionViewDataSource {
    
    var optionItems: [OptionItem] = []
    var selectedIndex = 0

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        optionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .sizeCellId, for: indexPath) as! SizeSelectionCell
        cell.size = optionItems[indexPath.row].name
        cell.isSelect = selectedIndex == indexPath.row
        return cell
    }
}
