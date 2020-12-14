//
//  EmptyView.swift
//  MSA
//
//  Created by Salah Amassi on 10/14/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static func initFromNib() -> EmptyView {
        return Bundle.init(for: EmptyView.self).loadNibNamed(.emptyView, owner: self, options: nil)!.first as! EmptyView
    }
    
    func addToParent(_ view: UIView, with title: String, mustConstraintToBottom: Bool = false, bottomConstant: CGFloat = 0.0){
        if self.subviews.contains(view){ return }
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if mustConstraintToBottom{
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant).isActive = true
        }else{
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        titleLabel.text = title
    }
    
    func removeFromParent(){
        removeFromSuperview()
    }
}
