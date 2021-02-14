//
//  PriceSeekBarView.swift
//  balbid
//
//  Created by Apple on 12/02/2021.
//

import UIKit

class PriceSeekBarView: UIView {

    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorView: UIStackView!
    

    class func initFromNib() -> PriceSeekBarView {
        return Bundle.init(for: PriceSeekBarView.self).loadNibNamed(.priceSeekBarView, owner: self, options: nil)!.first as! PriceSeekBarView
    }
    
    
  
    @IBAction func minPricePan(_ sender: UIPanGestureRecognizer) {
//        if sender.
        let points = sender.translation(in: indicatorView)
        let screenWidth = frame.width - 24
        if(points.x >= 0){
            if(points.x <= screenWidth){
               leadingConstraint.constant = points.x
            }
        }else{
            print("\( leadingConstraint.constant -  points.x)" + "gfg")
            leadingConstraint.constant +=  points.x
        }
        print(points.x)
        print(frame.width)
        print(screenWidth)
    }
    
    
  
}
