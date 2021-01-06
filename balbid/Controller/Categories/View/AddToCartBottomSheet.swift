//
//  AddToCartBottomSheet.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit

class AddToCartBottomSheet: BottomSheetView {

    override class func initFromNib() -> AddToCartBottomSheet {
        return Bundle.init(for: AddToCartBottomSheet.self).loadNibNamed(.addToCartView, owner: self, options: nil)!.first as! AddToCartBottomSheet
    }
    
    override func awakeFromNib() {
        viewHeight = 159
        super.awakeFromNib()
    }

}
