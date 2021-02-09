//
//  Extension+UIStoryboard.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit

extension UIStoryboard {

    static let mainStoryboard = UIStoryboard(name : .mainStoryboard, bundle: nil)
    static let authStoryboard = UIStoryboard(name: .authStoryboard, bundle: nil)
    static let splashStoryboard = UIStoryboard(name:.splashStoryboard, bundle: nil)
    static let authComapnyStoryboard = UIStoryboard(name: .authComapnyStoryboard, bundle: nil)
    static let categoriesStoryboard = UIStoryboard(name: .categoriesStoryboard, bundle: nil)
    static let productStoryboard = UIStoryboard(name: .productStoryboard, bundle: nil)
    static let profileStoryboard = UIStoryboard(name: .profileStoryboard,
                                                bundle: nil)
    static let orderStoryboard = UIStoryboard(name:
        .orderStoryboard, bundle: nil)
    static let shippingStoryboard = UIStoryboard(name:
        .shippingStoryboard, bundle: nil)
    static let paymentStoryboard = UIStoryboard(name:
        .paymentStoryboard, bundle: nil)

    func getViewController(with identifier: String) -> UIViewController {
        return instantiateViewController(withIdentifier: identifier)
    }

}
