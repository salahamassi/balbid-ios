//
//  PaymentMethodDataSource.swift
//  balbid
//
//  Created by Apple on 12/03/2021.
//

import UIKit

class PaymentMethodDataSource: NSObject, UICollectionViewDataSource {
    
    var paymentMethods: [PaymentMethod] = []
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .paymentCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paymentMethods.count
    }
    
}

