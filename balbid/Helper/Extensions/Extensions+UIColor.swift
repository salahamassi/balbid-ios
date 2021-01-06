//
//  Extensions+UIColor.swift
//  MSA
//
//  Created by Salah Amassi on 10/14/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UIColor {

    static func appColor(_ name: AssetsColor) -> UIColor? {
       return UIColor(named: name.rawValue)
    }
    
    static func random() -> UIColor {
        return UIColor(
           red:   .random(in: 0...1),
           green: .random(in: 0...1),
           blue:  .random(in: 0...1),
           alpha: 1.0
        )
    }


}
