//
//  CartTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class CartCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var count = 10

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .cartCellId, for: indexPath)
        return cell
    }
    
    
    
  

}
