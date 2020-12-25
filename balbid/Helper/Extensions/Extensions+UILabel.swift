//
//  Extensions+UILabel.swift
//  MSA
//
//  Created by Salah Amassi on 10/27/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UILabel {

   convenience init(text: String? = nil, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .natural, numberOfLines: Int = 1, backgroundColor: UIColor? = nil) {
       self.init()
       self.text = text
       self.font = font
       self.textColor = textColor
       self.textAlignment = textAlignment
       self.numberOfLines = numberOfLines
       if let backgroundColor = backgroundColor {
           self.backgroundColor = backgroundColor
       }
   }

   static func estimatedSize(_ text: String, targetSize: CGSize = .zero, numberOfLines: Int = 0, font: UIFont? = nil) -> CGSize {
       let label = UILabel(frame: .zero)
       label.numberOfLines = numberOfLines
       label.text = text
       if let font = font {
           label.font = font
       }
       return label.sizeThatFits(targetSize)
   }

   func animateChangeTextColor(with duration: Double = 0.6, _ color: UIColor) {
       UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .autoreverse, .repeat], animations: {
           self.textColor = color
       }, completion: nil)
   }

   func addCharactersSpacing(_ value: CGFloat = 1.15) {
       if let textString = text {
           let attrs: [NSAttributedString.Key: Any] = [.kern: value]
           attributedText = NSAttributedString(string: textString, attributes: attrs)
       }
   }
}
