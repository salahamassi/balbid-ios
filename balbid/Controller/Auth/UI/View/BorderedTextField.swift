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

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
    }

    var isActive: Bool = false {
        didSet {
            if !isInsideContainer {
                animateBorder(with: UIColor.appColor(isActive ? .primaryColor : .lightGrayColor) ?? .clear, border: 1)
            } else {
                containerView.animateBorder(with: UIColor.appColor(isActive ? .primaryColor : .lightGrayColor) ?? .clear, border: 1)
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
