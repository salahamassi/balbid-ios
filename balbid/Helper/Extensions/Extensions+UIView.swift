//
//  Extensions + UIView.swift
//  MSA
//
//  Created by Salah Amassi on 10/10/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UIView {

    typealias CompletionHandler = () -> Void
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set(newValue) {
            withCornerRadius(newValue)
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set(newValue) {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let val = layer.borderColor else {
                return nil
            }
            return  UIColor(cgColor: val)
        }set(newValue) {
            layer.borderColor = newValue?.cgColor
        }
    }

    convenience init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }

    @discardableResult
    func withBackgroundColor(_ color: UIColor) -> UIView {
        backgroundColor = color
        return self
    }

    @discardableResult
    func withFrame(_ frame: CGRect) -> UIView {
        self.frame = frame
        return self
    }

    @discardableResult
    func withHidden(_ hidden: Bool) -> UIView {
        isHidden = hidden
        return self
    }

    @discardableResult
    func withCornerRadius(_ cornerRadius: CGFloat) -> UIView {
        layer.cornerRadius = cornerRadius
        clipsToBounds  =  true
        return self
    }

    @discardableResult
    func withCornerRadius(_ cornerRadius: CGFloat, corners: CACornerMask) -> UIView {
        layer.maskedCorners = corners
        return withCornerRadius(cornerRadius)
    }

    @discardableResult
    func withBorder(_ borderWidth: CGFloat, borderColor: UIColor?) -> UIView {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        clipsToBounds  =  true
        return self
    }

    @discardableResult
    func withShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 0, spread: CGFloat = 0) -> UIView {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
        layer.masksToBounds = false
        return self
    }

    @discardableResult
    func withGradainate(with colors: [UIColor], locations: [NSNumber] = [0.0, 1.0], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, frame: CGRect? = nil) -> UIView {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        if let frame = frame {
            gradientLayer.frame = frame
        } else {
            gradientLayer.frame = bounds
        }
        gradientLayer.locations = locations
        if let startPoint = startPoint {
            gradientLayer.startPoint = startPoint
        }
        if let endPoint = endPoint {
            gradientLayer.endPoint = endPoint
        }
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
        return self
    }
    
    @discardableResult
    func withOuterBorder(with radius: CGFloat, strokeColor: UIColor, lineWidth:CGFloat, strokeEnd: CGFloat, startAngle: CGFloat = -CGFloat.pi / 2, endAngle: CGFloat = 2 * CGFloat.pi, fillColor: UIColor = .clear, clockwise: Bool = true) -> UIView {
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeEnd = strokeEnd
        layer.addSublayer(shapeLayer)
        return self
    }

    func animateBorder(with color: UIColor, border: CGFloat? = nil) {
        let colorBasicAnimation = CABasicAnimation(keyPath: "borderColor")
        colorBasicAnimation.fromValue = layer.borderColor
        colorBasicAnimation.toValue = color.cgColor
        colorBasicAnimation.duration = 0.3
        colorBasicAnimation.repeatCount = 1
        layer.borderColor = color.cgColor
        layer.add(colorBasicAnimation, forKey: "borderColor")

        let borderWidthBasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthBasicAnimation.fromValue = layer.borderWidth
        borderWidthBasicAnimation.toValue = color.cgColor
        borderWidthBasicAnimation.duration = 0.3
        borderWidthBasicAnimation.repeatCount = 1
        layer.borderWidth = border ?? 0.0
        layer.add(borderWidthBasicAnimation, forKey: "borderWidth")
    }

    func animateBackgroundColorChange(value: UIColor, duration: Double = 0.1, delay: Double = 0.0, springWithDamping: CGFloat = 0.4, initialSpringVelocity: CGFloat = 0.0, options: UIView.AnimationOptions = [.curveEaseIn], completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: springWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animations: {
            self.backgroundColor = value
        }, completion: {(_) in
            completion?()
        })
    }

    func animateAlphaChange(value: CGFloat, duration: Double = 0.1, delay: Double = 0.0, options: UIView.AnimationOptions = [.curveEaseIn], completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = value
        }, completion: {(_) in
            completion?()
        })
    }

    func animateIsHidden(value: Bool, duration: Double = 0.2, delay: Double = 0.0, options: UIView.AnimationOptions = [.curveLinear], completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.isHidden = value
            self.superview?.layoutIfNeeded()
        }, completion: {(_) in
            completion?()
        })
    }

    func animateTranslate(valueX: CGFloat = 0.0, valueY: CGFloat = 0.0, duration: Double = 0.2, delay: Double = 0.0, options: UIView.AnimationOptions = [], hidden: Bool = false, completion: CompletionHandler? = nil) {
        if valueX == 0 && valueY == 0 {
            isHidden = false
            removeAllTransforms(animated: true, duration: duration, delay: delay, hidden: hidden, completion: completion)
            return
        }
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.transform = .init(translationX: valueX, y: valueY)
        }, completion: {(_) in
            self.isHidden =  hidden
            completion?()
        })
    }

    func animateScale(valueX: CGFloat = 0.0, valueY: CGFloat = 0.0, duration: Double = 0.2, delay: Double = 0.0, options: UIView.AnimationOptions = [], hidden: Bool = false, completion: CompletionHandler? = nil) {
        if valueX == 0 && valueY == 0 {
            isHidden = false
            removeAllTransforms(animated: true, duration: duration, delay: delay, hidden: hidden, completion: completion)
            return
        }
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.transform = .init(scaleX: valueX, y: valueY)
        }, completion: {(_) in
            self.isHidden =  hidden
            completion?()
        })
    }

    func animateRotate(angle: CGFloat, duration: Double = 0.2, delay: Double = 0.0, options: UIView.AnimationOptions = [], hidden: Bool = false, completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }, completion: { (_) in
            completion?()
        })
    }

    func removeAllTransforms(animated: Bool = false, duration: Double  = 0.1, delay: Double = 0.0, options: UIView.AnimationOptions = [], hidden: Bool = false, completion: CompletionHandler? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                self.transform = .identity
            }, completion: { (_) in
                self.isHidden =  hidden
                completion?()
            })
        } else {
            transform = .identity
            isHidden =  hidden
            completion?()
        }
    }

    func animateConstraintsChange(duration: Double = 0.2, delay: Double = 0.0, options: UIView.AnimationOptions = [], springWithDamping: CGFloat = 0.4, initialSpringVelocity: CGFloat = 0.0, completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.layoutIfNeeded()
        }, completion: {(_) in
            completion?()
        })
    }

    func rotate360DegreesForever(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .infinity
        layer.add(rotateAnimation, forKey: nil)
    }

    enum UIViewFadeStyle {
        case bottom
        case top
        case left
        case right

        case vertical
        case horizontal
    }

    func fadeView(style: UIViewFadeStyle = .bottom, percentage: Double = 0.07) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]

        let startLocation = percentage
        let endLocation = 1 - percentage

        switch style {
        case .bottom:
            gradient.startPoint = CGPoint(x: 0.5, y: endLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .top:
            gradient.startPoint = CGPoint(x: 0.5, y: startLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]

        case .left:
            gradient.startPoint = CGPoint(x: startLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .right:
            gradient.startPoint = CGPoint(x: endLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]
        }

        layer.mask = gradient
    }
    
    

}
