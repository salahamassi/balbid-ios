//
//  LayoutHelper.swift
//  MSA
//
//  Created by Salah Amassi on 4/18/20. orignal code from LBTA Library
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

public struct AnchoredConstraints {
    public var top, leading, left, bottom, trailing, right, centerY, centerX, width, height: NSLayoutConstraint?
}

public typealias BarButtonItemAction = ((_ sender: UIBarButtonItem) -> Void)
public typealias ButtonAction = ((_ sender: UIButton) -> Void)

public enum Anchor {
    case top(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case left(_ left: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case leading(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case trailing(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case right(_ right: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerY(_ layoutYAxis: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case centerX(_ layoutXAxis: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case center(_ layoutYAxis: NSLayoutYAxisAnchor, constant: CGFloat = 0, layoutXAxis: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerYInParent(_ constant: CGFloat = 0)
    case centerXInParent(_ constant: CGFloat = 0)
    case centerInParent(_ constant: CGFloat = 0)
    case height(_ constant: CGFloat)
    case width(_ constant: CGFloat)
    case fillSuperView(_ padding: UIEdgeInsets = .zero)
    case fillSuperViewWithSafeAreaLayoutGuide(_ padding: UIEdgeInsets = .zero)
}

public extension UIView {

    @discardableResult
    func anchor(_ anchors: Anchor...) -> AnchoredConstraints {
        return anchor(anchors)
    }

    @discardableResult
    func anchor(_ anchors: [Anchor]) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchors.forEach { anchor in
            switch anchor {
            case .top(let anchor, let constant):
                anchoredConstraints.top = topAnchor.constraint(equalTo: anchor, constant: constant)

            case .leading(let anchor, let constant):
                anchoredConstraints.leading = leadingAnchor.constraint(equalTo: anchor, constant: constant)

            case .left(let anchor, let constant):
                anchoredConstraints.left = leftAnchor.constraint(equalTo: anchor, constant: constant)

            case .bottom(let anchor, let constant):
                anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: anchor, constant: -constant)

            case .trailing(let anchor, let constant):
                anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: anchor, constant: -constant)

            case .right(let anchor, let constant):
                anchoredConstraints.right = rightAnchor.constraint(equalTo: anchor, constant: -constant)

            case .centerY(let anchor, let constant):
                anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: anchor, constant: constant)

            case .centerX(let anchor, let constant):
                anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: anchor, constant: constant)

            case .center(let anchorY, let constantY, let anchorX, let constantX):
                anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: anchorY, constant: constantY)
                anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: anchorX, constant: constantX)

            case .centerYInParent(let constant):
                if let superview = superview {
                    anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
                }

            case .centerXInParent(let constant):
                if let superview = superview {
                    anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
                }

            case .centerInParent(let constant):
                if let superview = superview {
                    anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
                    anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
                }

            case .height(let constant):
                if constant > 0 {
                    anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
                }
            case .width(let constant):
                if constant > 0 {
                    anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
                }

            case .fillSuperView(let padding):
                anchoredConstraints = fillSuperview(padding: padding)

            case .fillSuperViewWithSafeAreaLayoutGuide(let padding):
                anchoredConstraints = fillSuperviewSafeAreaLayoutGuide(padding: padding)
            }
        }
        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.left,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.right,
         anchoredConstraints.centerY,
         anchoredConstraints.centerX,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach {
            $0?.isActive = true
        }
        return anchoredConstraints
    }

    // to not broke the app compatibility
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {

        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()

        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }

        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }

        if let right = right {
            anchoredConstraints.right = rightAnchor.constraint(equalTo: right, constant: -padding.right)
        }

        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        [ anchoredConstraints.top,
          anchoredConstraints.leading,
          anchoredConstraints.left,
          anchoredConstraints.bottom,
          anchoredConstraints.trailing,
          anchoredConstraints.right,
          anchoredConstraints.centerY,
          anchoredConstraints.centerX,
          anchoredConstraints.width,
          anchoredConstraints.height].forEach {
            $0?.isActive = true
        }

        return anchoredConstraints
    }

    @discardableResult
    func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }

        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }

    @discardableResult
    func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
            let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
            let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
            let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                return anchoredConstraints
        }
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }

    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }

        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    @discardableResult
    func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }

    @discardableResult
    func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
}
