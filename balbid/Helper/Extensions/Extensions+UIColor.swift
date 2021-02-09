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

extension UIColor {

    convenience init(hexString: String, alpha:CGFloat? = 1.0) {
        var hexInt: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)

        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha!

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
