//
//  ColorCollectionViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit

class ColorCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .colorCellId, for: indexPath)
        cell.contentView.backgroundColor = UIColor.random()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
}
