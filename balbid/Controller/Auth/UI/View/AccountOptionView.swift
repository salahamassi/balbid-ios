//
//  AccountOptionView.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit

class AccountOptionView: UIView {
    
  @IBOutlet weak var checkImageView : UIImageView?
  @IBOutlet weak var innerView : UIView?
  @IBOutlet weak var contentImageView : UIImageView?

    var isSet : Bool = false{
        didSet {
            self.innerView?.withBorder(isSet ? 2 : 0 , borderColor: isSet ? #colorLiteral(red: 0.1176470588, green: 0.137254902, blue: 0.3215686275, alpha: 1) : #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1))
            checkImageView?.isHidden = !isSet
            contentImageView?.tintColor = #colorLiteral(red: 0.1176470588, green: 0.137254902, blue: 0.3215686275, alpha: 1)
        }
    }
    
    
   
   

}
