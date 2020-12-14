//
//  AppNavigationViewController.swift
//  MSA
//
//  Created by Qamar Nahed on 10/3/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    private var shadowColor: UIColor?, backgroundEffect:  UIBlurEffect?, backgroundColor: UIColor?
    
    public weak var router: AppRouter?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        saveDefaultsNavigationBarAppearanceValues()
        setupInteractivePopGestureRecognizer()
    }
    
    private func saveDefaultsNavigationBarAppearanceValues(){
        if #available(iOS 13.0, *) {
            let backImage = #imageLiteral(resourceName: "round_arrow_back_ios_black_24pt")
            navigationBar.standardAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            navigationBar.tintColor = #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1),
                                                 NSAttributedString.Key.font: UIFont.bold.withSize(18)]
            backgroundColor =  navigationBar.standardAppearance.backgroundColor
            backgroundEffect = navigationBar.standardAppearance.backgroundEffect
            shadowColor = navigationBar.standardAppearance.shadowColor
        }else{
            navigationBar.barStyle = .default
            navigationBar.tintColor = .black
        }
    }
    
    func clear(){
        navigationBar.clear()
        navigationItem.hidesBackButton = false
    }
    
    func unclear(){
        navigationBar.unclear(shadowColor: shadowColor, backgroundEffect: backgroundEffect, backgroundColor: backgroundColor)
    }
    
    private func setupInteractivePopGestureRecognizer(){
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    
}

extension AppNavigationController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        if viewController.mustClearNavigationBar{
            clear()
        }else{
            unclear()
        }
        router?.currentViewController = viewController
        if viewController.mustHideNavigationBar{
            setNavigationBarHidden(true, animated: true)
        }else{
            setNavigationBarHidden(false, animated: true)
        }
    }
    
}
