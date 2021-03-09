//
//  SliderImageDelegate.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SliderImageDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: HomeSelectionProtocol?
    var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 155)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = collectionView.contentOffset.x / collectionView.frame.size.width
        delegate?.didMoveHomeSlider(to: Int(currentIndex))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
