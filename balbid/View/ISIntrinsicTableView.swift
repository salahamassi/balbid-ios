//
//  ISIntrinsicTableView.swift
//  Bizaty
//
//  Created by Amar Amassi  on 1/21/19.
//  Copyright © 2019 Amar Amassi . All rights reserved.
//
import UIKit

@IBDesignable class ISIntrinsicTableView: UITableView {

    @IBInspectable var initHeight: CGFloat = 300

    override var intrinsicContentSize: CGSize {
        // Drawing code
        layoutIfNeeded()
        #if TARGET_INTERFACE_BUILDER
        return CGSize(width: UIView.noIntrinsicMetric, height: initHeight)
        #else
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
        #endif
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

}
