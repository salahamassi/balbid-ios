//
//  Extensions+UITextField.swift
//  MSA
//
//  Created by Salah Amassi on 10/25/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

@IBDesignable
extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }

    @IBInspectable var rightImage: UIImage? {
        get {
            return ((rightView as? UIImageView)?.image)
        }
        set {
            let rightImageView = UIImageView(image: newValue)
            rightView = rightImageView
            rightViewMode = .always
        }
    }

    @IBInspectable var setPassowrdImage: Bool {
        get {
            return false
        }
        set {
            if newValue {
                let lockButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
                lockButton.addTarget(self, action: #selector(togglePasswordIcon), for: .primaryActionTriggered)
                lockButton.setImage(UIImage(named: .lockedPasswordImage), for: .normal)
                lockButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
                lockButton.tintColor =  #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
                rightView = lockButton
                rightViewMode = .always
            }
        }
    }

    @objc
    private func togglePasswordIcon(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: .lockedPasswordImage) {
            sender.setImage(UIImage(named: .unlockedPasswordImage), for: .normal)
            isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(named: .lockedPasswordImage), for: .normal)
            isSecureTextEntry = true
        }
    }

}
