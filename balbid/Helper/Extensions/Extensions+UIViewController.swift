//
//  Extensions+UIViewController.swift
//  MSA
//
//  Created by Salah Amassi on 10/10/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UIViewController {

    func displayAlert(message: String) {
        let errorAlert = ErrorAlert.initFromNib()
        errorAlert.message = "\(message)"
        errorAlert.actionButtonTitle = "keyword.ok".localized
        errorAlert.didPressActionButton = .some({ [weak self] (_) in
            guard let _ = self else { return }
            errorAlert.hide()
        })
        errorAlert.show(with: (message.height(withConstrainedWidth: UIScreen.main.bounds.size.width - 32, font: UIFont.medium.withSize(14))) + 128)
    }

    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-220, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }

    func displayAlert(title: String, message: String, defaultButtonTitle: String, destructiveButtonTitle: String?, completion:  @escaping() -> Void) {
        let confirmAlert = ConfirmAlert.initFromNib()
        let titleHeight = title.height(withConstrainedWidth: UIScreen.main.bounds.size.width - 32, font: UIFont.bold.withSize(15))
        let messageHeight = message.height(withConstrainedWidth: UIScreen.main.bounds.size.width - 32, font: UIFont.regular.withSize(15))
        confirmAlert.title = title
        confirmAlert.message = message
        confirmAlert.defaultButtonTitle = defaultButtonTitle
        confirmAlert.destructiveButtonTitle = destructiveButtonTitle
        confirmAlert.defaultButtonAction = .some({ [weak self] (_) in
            guard let _ = self else { return }
            confirmAlert.hide {
                completion()
            }
        })
        confirmAlert.destructiveButtonAction = .some({ [weak self] (_) in
            guard let _ = self else { return }
            confirmAlert.hide()
        })
        confirmAlert.viewHeight = titleHeight + messageHeight + 128
        confirmAlert.show()
    }

    @objc
    var mustClearNavigationBar: Bool {
        get {
            return false
        }
    }

    @objc
    var mustHideNavigationBar: Bool {
        get {
            return false
        }
    }

    var statusBarHeight: CGFloat {
        get {
            if #available(iOS 13.0, *) {
                return (UIApplication.shared.delegate as? AppDelegate)?.appWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
            } else {
                return UIApplication.shared.statusBarFrame.size.height
            }
        }
    }

    var safeAreaHeight: CGFloat {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.appWindow?.safeAreaInsets.bottom ?? .zero
        }
    }

    func add(_ viewController: UIViewController, to view: UIView? = nil, frame: CGRect) {
        addChild(viewController)
        viewController.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        if let view =  view {
            view.addSubview(viewController.view)
        } else {
            self.view.addSubview(viewController.view)
        }
        viewController.didMove(toParent: viewController)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

}
