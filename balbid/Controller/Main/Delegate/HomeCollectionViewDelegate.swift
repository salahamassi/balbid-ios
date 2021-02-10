//
//  HomeCollectionViewDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import UIKit

class HomeCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var delegate: HomeSelectionProtocol?
    let collectionView: UICollectionView
    
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.didSelect(item : indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = collectionView.contentOffset.x / collectionView.frame.size.width
        delegate?.didMoveHomeSlider(to: Int(currentIndex))
    }

    
}
