//
//  SliderIndicatorCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 27/12/2020.
//

import UIKit

class SliderIndicatorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
  
}
