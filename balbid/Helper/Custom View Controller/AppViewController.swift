//
//  AppViewController.swift
//  MSA
//
//  Created by Salah Amassi on 27/11/2020.
//  Copyright © 2020 MSA. All rights reserved.
//

import Foundation

import UIKit

class AppViewController<View: UIView>: UIViewController {
    
    var customView: View{
        return view as! View
    }
    
    weak var router: AppRouter?
    
    @available(iOS 12.0, *)
    var isDarkMode: Bool{
        UserDefaultsManager.isDarkMode || traitCollection.userInterfaceStyle == .dark
    }
    
    public init(router: AppRouter? = nil) {
        self.router = router
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
