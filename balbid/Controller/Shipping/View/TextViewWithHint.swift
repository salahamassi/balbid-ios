//
//  TextViewWithHint.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit

class TextViewWithHint: UITextView {

    @IBInspectable
    var hint : String = ""  {
        didSet {
            self.text = hint
            self.textColor = hintColor
        }
    }
    var roundedView : UIView!
    
    var maxNumOfCharacter : Int!
    var shouldStopWriting = false
    
    @IBInspectable
    var hintColor : UIColor = .gray
    
    @IBInspectable
    var normalTextColor : UIColor = .black
    
   
    override func awakeFromNib() {
        self.delegate = self
        self.text = hint
        self.textColor = hintColor
        
    }

    var isActive: Bool = false {
        didSet {
            animateBorder(with: UIColor.appColor(isActive ? .primaryColor : .lightGrayColor) ?? .clear, border: 1)
        }
    }

}

extension TextViewWithHint : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == hintColor {
            textView.text = nil
            textView.textColor = normalTextColor
        }
        isActive = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil || textView.text == ""  {
            self.text = hint
            self.textColor = hintColor
        }
        
        isActive = false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if shouldStopWriting {
            let currentText = textView.text as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: text)
            
            return updatedText.count <= maxNumOfCharacter
        }
        
        return true
    }

}
