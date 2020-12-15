//
//  Extension+UIStoryboard.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit

extension UIStoryboard {
//    static let mainStoryboard = UIStoryboard(name : .mainStoryboard, bundle: nil)
    static let authStoryboard = UIStoryboard(name : .authStoryboard, bundle: nil)
    static let splashStoryboard = UIStoryboard(name : .splashStoryboard, bundle: nil)

    func getViewController(with identifier : String) -> UIViewController{
        return instantiateViewController(withIdentifier: identifier)
    }

}
