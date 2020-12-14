//
//  Extenstions+UICollectionViewFlowLayout.swift
//  MSA
//
//  Created by Salah Amassi on 4/9/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout{
    
    convenience init(scrollDirection: UICollectionView.ScrollDirection = UICollectionView.ScrollDirection.vertical){
        self.init()
        self.scrollDirection = scrollDirection
    }
}
