//
//  SizeSelectionDelegate.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SizeSelectionDelegate: NSObject, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    var optionItems: [OptionItem] = []

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         CGSize(width: optionItems[indexPath.row].name.width(withConstrainedHeight: 40, font: .medium) + 20 , height: 40)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         0
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
