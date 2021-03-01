//
//  BorderedTextField.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit

class BorderedTextField: UITextField, UITextFieldDelegate {

    @IBOutlet weak var containerView: UIView!

    @IBInspectable var isInsideContainer: Bool = false
    
    var isError: Bool = false {
        didSet{
            if isError {
                if !isInsideContainer {
                    layer.borderColor =  (UIColor.appColor(.redColor)  ?? .clear).cgColor
                    layer.borderWidth = 1
                } else {
                    containerView.layer.borderColor =  (UIColor.appColor(.redColor)  ?? .clear).cgColor
                    containerView.layer.borderWidth = 1
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
    }

    var isActive: Bool = false {
        didSet {
            if !isInsideContainer {
                layer.borderColor =  (UIColor.appColor(isActive ? .primaryColor : .lightGrayColor)  ?? .clear).cgColor
                layer.borderWidth = 1
            } else {
                containerView.layer.borderColor =  (UIColor.appColor(isActive ? .primaryColor : .lightGrayColor)  ?? .clear).cgColor
                containerView.layer.borderWidth = 1
            }
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isActive = true
        return isActive
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isActive = false
    }

}
