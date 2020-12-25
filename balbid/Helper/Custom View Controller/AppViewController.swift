//
//  AppViewController.swift
//  MSA
//
//  Created by Salah Amassi on 27/11/2020.
//  Copyright © 2020 MSA. All rights reserved.
//

import Foundation
import UIKit
import AppRouter

class AppViewController<View: UIView>: UIViewController {

    var customView: View {
        return view as! View
    }


    @available(iOS 12.0, *)
    var isDarkMode: Bool {
        UserDefaultsManager.isDarkMode || traitCollection.userInterfaceStyle == .dark
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("Fuck storyboard!")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
