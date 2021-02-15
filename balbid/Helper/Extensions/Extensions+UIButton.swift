//
//  Extensions+UIButton.swift
//  MSA
//
//  Created by Salah Amassi on 10/10/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

var tempTitle: String?
var tempImage: UIImage?

extension UIButton {

    convenience init(title: String, titleColor: UIColor, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font

        self.backgroundColor = backgroundColor
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }

    convenience init(image: UIImage?, tintColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }

        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }

    convenience init(target: Any? = nil, action: Selector? = nil) {
        self.init(type: .custom)
        if let action = action {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }

    @discardableResult
    func addTouchDownTarget(target: Any, action: Selector) -> UIButton {
        addTarget(target, action: action, for: .touchDown)
        addTarget(target, action: action, for: .touchDownRepeat)
        addTarget(target, action: action, for: .touchDragInside)
        addTarget(target, action: action, for: .touchDragEnter)
        return self
    }

    @discardableResult
    func addTouchUpTarget(target: Any, action: Selector) -> UIButton {
        addTarget(target, action: action, for: .touchUpInside)
        addTarget(target, action: action, for: .touchUpOutside)
        addTarget(target, action: action, for: .touchDragOutside)
        addTarget(target, action: action, for: .touchDragExit)
        addTarget(target, action: action, for: .touchCancel)
        return self
    }

    @discardableResult
    func addPrimaryActionTarget(target: Any, action: Selector) -> UIButton {
        addTarget(target, action: action, for: .primaryActionTriggered)
        return self
    }

    func animateImageChange(_ image: UIImage) {
        guard let imageView = imageView else { return }
        UIView.transition(with: imageView,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { self.setImage(image, for: .normal) },
                          completion: nil)
    }

    func loadingIndicator(_ show: Bool, centerPoint: CGPoint? = nil) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 1
            let indicator = UIActivityIndicatorView()
            if #available(iOS 13.0, *) {
                indicator.style = .medium
            } else {
                indicator.style = .gray
            }
            indicator.color = .red
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = centerPoint == nil ? CGPoint(x: buttonWidth/2, y: buttonHeight/2) : centerPoint!
            indicator.tag = tag
            self.addSubview(indicator)
            tempTitle = self.titleLabel?.text
            tempImage = self.imageView?.image
            setTitle(nil, for: .normal)
            setImage(nil, for: .normal)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
            setTitle(tempTitle, for: .normal)
            setImage(tempImage, for: .normal)
        }
    }

}
