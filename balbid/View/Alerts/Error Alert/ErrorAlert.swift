//
//  ErrorAlert.swift
//  MSA
//
//  Created by Salah Amassi on 10/29/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class ErrorAlert: BaseDialog {
    
    override class func initFromNib() -> ErrorAlert {
        return Bundle.main.loadNibNamed(.errorAlertView, owner: self, options: nil)!.first as! ErrorAlert
    }
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var didPressActionButton: ((_ button: UIButton)->Void)?
    
    var actionButtonTitle: String?{
        didSet{
            actionButton?.setTitle(actionButtonTitle, for: .normal)
        }
    }
    var message: String?{
        didSet{
            messageLabel?.text = message
        }
    }
    
    override func awakeFromNib() {
        mustUseTransitioner = true
        mustHideWhenTapOutSide = true
        super.awakeFromNib()
    }
    
    override func show(with height: CGFloat,and width: CGFloat? = nil, centerYPadding: CGFloat = 0, animated: Bool = false) {
        super.show(with: height, centerYPadding: centerYPadding, animated: animated)
    }

    override func hide(animated: Bool = false, completion: (() -> Void)? = nil) {
        super.hide(animated: animated, completion: completion)
    }
    
    @IBAction func performButtonAction(_ sender: UIButton){
        didPressActionButton?(sender)
    }
    
}
