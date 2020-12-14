//
//  BaseCollectionViewCell.swift
//  MSA
//
//  Created by Salah Amassi on 10/10/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class BaseCollectionViewCell<E>: UICollectionViewCell{
    
    public var item: E?{
        didSet{
            renderItem(item: item)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func renderItem(item: E?){
        preconditionFailure("This method must be overridden")
    }
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction]) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } else {
                self.transform = .identity
            }
        }
    }
    
}
