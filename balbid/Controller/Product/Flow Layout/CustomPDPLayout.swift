//
//  CustomPDPLayout.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class CustomPDPLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttribute = super.layoutAttributesForElements(in: rect)
        layoutAttribute?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else { return }
                let contentOffsetY = collectionView.contentOffset.y
                if contentOffsetY < 0 {
                    let width = collectionView.frame.width
                    // as contentOffsetY is -ve, the height will increase based on contentOffsetY
                    let height = attribute.frame.height - contentOffsetY
                    attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                }
            }
        })
        return layoutAttribute
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
