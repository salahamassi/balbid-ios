//
//  Extension+UIImageView.swift
//  MSA
//
//  Created by Salah Amassi on 27/11/2020.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UIImageView {

   convenience init(image: UIImage? = nil, tintColor: UIColor? = nil) {
       self.init(image: image)
       self.tintColor = tintColor
   }

   convenience init(image: UIImage? = nil, contentMode: ContentMode? = nil, clipsToBounds: Bool = false) {
       self.init(image: image)
       self.tintColor = tintColor
       if let contentMode = contentMode {
           self.contentMode = contentMode
       }
       self.clipsToBounds = clipsToBounds
   }

   @discardableResult
   func withTintColor(_ color: UIColor) -> UIImageView {
       tintColor = color
       return self
   }

    @discardableResult
    func withAnimatedTintColor(_ color: UIColor) -> UIImageView {
        UIView.animate(withDuration: 0.8, delay: 0, options: [], animations: {
            self.tintColor = color
        }, completion: nil)
        return self
    }

   func enableZoom() {
       let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
       isUserInteractionEnabled = true
       addGestureRecognizer(pinchGesture)
   }

   @objc
   private func startZooming(_ sender: UIPinchGestureRecognizer) {
       let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
       guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
       sender.view?.transform = scale
       sender.scale = 1
   }

}
