//
//  FilterCollectionViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class FilterCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var filters: [String] = []
    var didSelectItem: ((_ indexPath: IndexPath) -> ())?
    
    
    required init( filters: [String]) {
        self.filters = filters
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 28
        let width = filters[indexPath.row].width(withConstrainedHeight: height, font: UIFont.medium.withSize(10))
        return .init(width: width + 20, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
}
