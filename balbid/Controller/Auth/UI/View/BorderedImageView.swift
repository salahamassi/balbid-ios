//
//  BorderedImageView.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import UIKit

class BorderedImageView: UIImageView {

    var isError: Bool = false {
        didSet{
            if isError {
                layer.borderColor =  (UIColor.appColor(.redColor)  ?? .clear).cgColor
                layer.borderWidth = 1
            }else {
                layer.borderWidth = 0
            }
        }
    }
}
