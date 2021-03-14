//
//  BaseViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 14/12/2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let darkLayer = CALayer()

    
    func addDarkView(below view: UIView?){
        guard let view = view else {
            return
        }
        darkLayer.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.7).cgColor
        darkLayer.frame = UIScreen.main.bounds
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.layer.insertSublayer(self.darkLayer, below:  view.layer)
        }
    }
    
    func removeDarkView(){
        UIView.animate(withDuration: 0.5) {
            self.darkLayer.removeFromSuperlayer()
        }
    }
    
    func loginAlert(){
        let title = "You Need login to access this feature"
        let alertView = UIAlertController(title: title, message:"go to login? ", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "yes", style: .default, handler: {(action:UIAlertAction!) in
            self.router?.navigate(to: .loginRoute)
        }))
        alertView.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}
