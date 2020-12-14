//
//  Extensions+UINavigationBar.swift .swift
//  MSA
//
//  Created by Salah Amassi on 10/10/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UINavigationBar{
    
    func clear(){
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        if #available(iOS 13.0, *) {
            standardAppearance.backgroundColor = .clear
            standardAppearance.backgroundEffect = .none
            standardAppearance.shadowColor = .clear
        }
    }
    
    func unclear(shadowColor: UIColor?, backgroundEffect:  UIBlurEffect?, backgroundColor: UIColor?){
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
        if #available(iOS 13.0, *) {
            standardAppearance.backgroundColor = backgroundColor
            standardAppearance.backgroundEffect = backgroundEffect
            standardAppearance.shadowColor = shadowColor
        }
    }
}
