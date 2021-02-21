//
//  PaginateDelegate.swift
//  balbid
//
//  Created by Apple on 19/02/2021.
//

import UIKit

class PaginateDelegate: NSObject, UIScrollViewDelegate {
    
    var paginate: (() -> Void)?
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            paginate?()
        }
    }
}
