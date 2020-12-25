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

}
