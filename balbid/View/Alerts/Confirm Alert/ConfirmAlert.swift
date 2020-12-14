//
//  ConfirmAlert.swift
//  MSA
//
//  Created by Salah Amassi on 10/29/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class ConfirmAlert: BottomSheetView {
    
    override class func initFromNib() -> ConfirmAlert {
        return Bundle.main.loadNibNamed(.confirmAlertView, owner: self, options: nil)!.first as! ConfirmAlert
    }
    
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var destructiveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var defaultButtonAction: ((_ button: UIButton)->Void)?
    var destructiveButtonAction: ((_ button: UIButton)->Void)?
    
    var defaultButtonTitle: String?{
        didSet{
            defaultButton?.setTitle(defaultButtonTitle, for: .normal)
        }
    }
    
    var destructiveButtonTitle: String?{
        didSet{
            destructiveButton.isHidden = destructiveButtonTitle == nil
            destructiveButton?.setTitle(destructiveButtonTitle, for: .normal)
        }
    }
    
    var title: String?{
        didSet{
            titleLabel?.text = title
        }
    }
    
    var message: String?{
        didSet{
            messageLabel?.text = message
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        withCornerRadius(12, corners: [.topLeft, .topRight])
        destructiveButton.withBorder(1, borderColor: UIColor.appColor(.primaryColor))
    }
    
    @IBAction func performDefaultButtonAction(_ sender: UIButton){
        defaultButtonAction?(sender)
    }
    
    @IBAction func performDestructiveButtonAction(_ sender: UIButton){
        destructiveButtonAction?(sender)
    }
    
}
