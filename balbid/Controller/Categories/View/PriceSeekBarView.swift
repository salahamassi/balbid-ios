//
//  PriceSeekBarView.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit

class PriceSeekBarView: UIView {

    
    @IBOutlet weak var indicatorView: UIStackView!
    

    class func initFromNib() -> PriceSeekBarView {
        return Bundle.init(for: PriceSeekBarView.self).loadNibNamed(.priceSeekBarView, owner: self, options: nil)!.first as! PriceSeekBarView
    }
    
    
  
    @IBAction func minPriceSwipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            print(sender.state)
        }
    }
    
  
}
