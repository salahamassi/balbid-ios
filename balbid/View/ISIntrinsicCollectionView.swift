//
//  ISIntrinsicCollectionView.swift
//  bayty
//
//  Created by Amar Amassi  on 2/5/19.
//  Copyright © 2019 bayty. All rights reserved.
//

import UIKit

class ISIntrinsicCollectionView: UICollectionView {

    override var intrinsicContentSize : CGSize {
        // Drawing code
        layoutIfNeeded()
        
        #if TARGET_INTERFACE_BUILDER
        return CGSize(width: UIView.noIntrinsicMetric, height: 300);//CGSizeMake(UIViewNoIntrinsicMetric, 300);
        #else
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height);
        #endif
        
    }
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

}
