//
//  SliderIndicatorCollectionViewCell.swift
//  balbid
//
//  Created by Qamar Nahed on 27/12/2020.
//

import UIKit

class SliderIndicatorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    weak var delegate: SliderIndicatorCollectionViewCellDelegate?
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
  
    @IBAction func pageChanged(_ sender: Any) {
        delegate?.didChangePage(to: pageControl.currentPage)
    }
}



protocol  SliderIndicatorCollectionViewCellDelegate: class {
    func didChangePage(to page: Int)
}
