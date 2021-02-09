//
//  Extension+CATransition.swift
//  balbid
//
//  Created by Memo Amassi on 09/02/2021.
//

import UIKit

extension CATransition {

    static var fadeTransition: CATransition {
        let transition = CATransition()
        transition.type = .fade
        transition.subtype = .none
        transition.duration = 0.6
        return transition
    }
    
}
