//
//  Extensions+view+stacking.swift
//  MSA
//
//  Created by Salah Amassi on 4/18/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

public extension NSObject {

    private func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }

    @discardableResult
    func stack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }

    @discardableResult
    func hstack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }

    func view(backgroundColor: UIColor = .clear) -> UIView {
        return UIView(backgroundColor: backgroundColor)
    }

    func spreatorLine(_ height: CGFloat, color: UIColor) -> UIView {
        return UIView(backgroundColor: color).withHeight(height)
    }

    func label(text: String? = nil, font: UIFont? = nil, textColor: UIColor = .black, textAlignment: NSTextAlignment = .natural, numberOfLines: Int = 1) -> UILabel {
        return UILabel(text: text, font: font, textColor: textColor, textAlignment: textAlignment, numberOfLines: numberOfLines)
    }

    func image(image: UIImage, tintColor: UIColor? = nil) -> UIImageView {
        return UIImageView(image: image, tintColor: tintColor)
    }

    func image(image: UIImage? = nil, contentMode: UIView.ContentMode? = nil, clipsToBounds: Bool = false) -> UIImageView {
        return UIImageView(image: image, contentMode: contentMode, clipsToBounds: clipsToBounds)
    }

    func button(image: UIImage? = nil, tintColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) -> UIButton {
        if let image = image {
            return UIButton(image: image, tintColor: tintColor, target: target, action: action)
        } else {
            return UIButton(target: target, action: action)
        }
    }

    func button(title: String, titleColor: UIColor, font: UIFont, target: Any? = nil, action: Selector? = nil) -> UIButton {
        return UIButton(title: title, titleColor: titleColor, font: font, target: target, action: action)
    }

    func scroll(_ contentView: UIView, alwaysBounceVertical: Bool = false) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = alwaysBounceVertical
        scrollView.addSubview(contentView)
        contentView.anchor(.top(scrollView.contentLayoutGuide.topAnchor, constant: 0),
                           .leading(scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
                           .bottom(scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
                           .trailing(scrollView.contentLayoutGuide.trailingAnchor, constant: 0))
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        return scrollView
    }
}

public extension UIView {

    @discardableResult
    func addView<T: UIView>(_ child: UIView, anchors: Anchor...) -> T {
        self.addSubview(child)
        child.anchor(anchors)
        return self as! T
    }

    @discardableResult
    func withMargin(_ edgeInsets: UIEdgeInsets) -> UIView {
        let view = UIView()
        view.addSubview(self)
        view.backgroundColor = .clear
        fillSuperview(padding: edgeInsets)
        return view
    }

    @discardableResult
    func withSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }

    @discardableResult
    func withHeight<T: UIView>(_ height: CGFloat) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self as! T
    }

    @discardableResult
    func withWidth<T: UIView>(_ width: CGFloat) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self as! T
    }

    func spacer() -> UIView {
        return UIView().withBackgroundColor(.clear)
    }
}

public extension UIStackView {

    @discardableResult
    func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }

    @discardableResult
    func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }

    @discardableResult
    func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }

    @discardableResult
    func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }

    @discardableResult
    func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }

}

public extension UIEdgeInsets {

    static func allSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }

}
