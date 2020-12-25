//
//  BaseDialog.swift
//  MSA
//
//  Created by Salah Amassi on 10/29/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class BaseDialog: UIView {

    class func initFromNib() -> BaseDialog {
        preconditionFailure("This method must be overridden")
    }

    var centerYConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    let viewController = UIViewController()
    let transitioner = CAVTransitioner()

    var mustUseTransitioner: Bool = false
    var mustHideWhenTapOutSide: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = UserDefaultsManager.isDarkMode || traitCollection.userInterfaceStyle == .dark ? .dark : .light
            viewController.overrideUserInterfaceStyle = UserDefaultsManager.isDarkMode || traitCollection.userInterfaceStyle == .dark ? .dark : .light
        }
        setupDialog()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDialog()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupDialog() {
        viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        viewController.view.frame = UIScreen.main.bounds
        viewController.view.addSubview(self)
        if mustUseTransitioner {
            viewController.modalPresentationStyle = .custom
            viewController.transitioningDelegate = transitioner
        } else {
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overCurrentContext
        }
        translatesAutoresizingMaskIntoConstraints = false
        widthConstraint = widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.79)
        widthConstraint?.isActive = true
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        centerYConstraint = centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: viewController.view.frame.height)
        centerYConstraint?.isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBlackMaskView(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapGestureRecognizer)
    }

    func showDebug(with height: CGFloat, and width: CGFloat? = nil, centerYPadding: CGFloat = 0) {
        self.centerYConstraint?.constant = centerYPadding
        self.heightConstraint?.constant = height
        if let width = width {
            self.widthConstraint?.constant = width
        }
        viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        viewController.view.layoutIfNeeded()
    }

    func show(with height: CGFloat, and width: CGFloat? = nil, centerYPadding: CGFloat = 0, animated: Bool = true) {
        guard var rootViewController = (UIApplication.shared.delegate as? AppDelegate)?.appWindow?.rootViewController else { return }
        if !animated {
            self.centerYConstraint?.constant = centerYPadding
            self.heightConstraint?.constant = height
            if let width = width {
                self.widthConstraint?.constant = width
            } else {

            }
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            viewController.view.layoutIfNeeded()
            self.layoutIfNeeded()
        }
        rootViewController = rootViewController.presentedViewController == nil ? rootViewController : rootViewController.presentedViewController!
        rootViewController.present(viewController, animated: true) {
            self.centerYConstraint?.constant = centerYPadding
            self.heightConstraint?.constant = height
            if let width = width {
                self.widthConstraint?.constant = width
            }
            if animated {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                    self.viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    self.viewController.view.layoutIfNeeded()
                    self.layoutIfNeeded()
                })
            }
        }
    }

    func hide(animated: Bool = true, completion: (() -> Void)? = nil) {
        centerYConstraint?.constant = viewController.view.frame.height
        heightConstraint?.constant = 0
        if animated {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0)
                self.layoutIfNeeded()
                self.viewController.view.layoutIfNeeded()
            }, completion: { (_) in
                self.viewController.dismiss(animated: false, completion: completion)
            })
        } else {
            layoutIfNeeded()
            viewController.view.layoutIfNeeded()
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            viewController.dismiss(animated: false, completion: completion)
        }
    }

    @objc
    private func didTapBlackMaskView(_ sender: UITapGestureRecognizer) {
        if frame.contains(sender.location(in: viewController.view)) { return }
        if mustHideWhenTapOutSide {
            hide()
        }
    }
}
