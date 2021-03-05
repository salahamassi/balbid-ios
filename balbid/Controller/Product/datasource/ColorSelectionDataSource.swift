//
//  ColorSelectionDataSource.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class ColorSelectionDataSource: NSObject, UICollectionViewDataSource {
    
    var optionItems: [OptionItem] = []

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        optionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .colorCellId, for: indexPath) as! ColorSelectionCell
        cell.color = optionItems[indexPath.row].name
        return  cell
    }
    

}