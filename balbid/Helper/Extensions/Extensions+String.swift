//
//  Extensions+String.swift
//  MSA
//
//  Created by Salah Amassi on 10/10/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension String{
    
    var encodedText: String?{
        return addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var localized: String {
        get{
            return NSLocalizedString(self, comment: self)
        }
    }
    
    func convertToMutableAttributedString(with font: UIFont?, and color: UIColor) -> NSMutableAttributedString{
        let attrs: [NSAttributedString.Key : Any]
        if let font = font{
            attrs = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color] as [NSAttributedString.Key : Any]
        }else{
            attrs = [NSAttributedString.Key.foregroundColor : color] as [NSAttributedString.Key : Any]
        }
        return NSMutableAttributedString(string: self, attributes: attrs)
    }
    
    func convertToAttributedString(with font: UIFont?, and color: UIColor,and strikethrough: NSUnderlineStyle? = nil, with underlineStyle: NSUnderlineStyle? = nil) -> NSAttributedString{
        var attrs = [NSAttributedString.Key : Any]()
        if let font = font{
            attrs[NSAttributedString.Key.font] = font
        }
        if let strikethrough = strikethrough{
            attrs[NSAttributedString.Key.strikethroughStyle] = strikethrough.rawValue
        }
        if let underlineStyle = underlineStyle{
            attrs[NSAttributedString.Key.underlineStyle] = underlineStyle.rawValue
        }
        attrs[NSAttributedString.Key.foregroundColor] = color
        return NSAttributedString(string: self, attributes: attrs)
    }
    
    var regularAttributedString: NSAttributedString{
        let attrsRegular = [NSAttributedString.Key.font : UIFont.regular.withSize(14), NSAttributedString.Key.foregroundColor : UIColor.black] as [NSAttributedString.Key : Any]
        return NSAttributedString(string: self, attributes: attrsRegular)
    }
    
    var boldAttributedString: NSAttributedString{
        let attrsRegular = [NSAttributedString.Key.font : UIFont.bold.withSize(16), NSAttributedString.Key.foregroundColor : UIColor.black] as [NSAttributedString.Key : Any]
        return NSAttributedString(string: self, attributes: attrsRegular)
    }
    
    var mediumAttributedString: NSAttributedString{
        let attrsRegular = [NSAttributedString.Key.font : UIFont.medium.withSize(14), NSAttributedString.Key.foregroundColor : UIColor.black] as [NSAttributedString.Key : Any]
        return NSAttributedString(string: self, attributes: attrsRegular)
    }
    
    
    var regularMutableAttributedString: NSMutableAttributedString{
        let attrsRegular = [NSAttributedString.Key.font : UIFont.regular.withSize(14), NSAttributedString.Key.foregroundColor : UIColor.black] as [NSAttributedString.Key : Any]
        return NSMutableAttributedString(string: self, attributes: attrsRegular)
    }
    
    var boldMutableAttributedString: NSMutableAttributedString{
        let attrsRegular = [NSAttributedString.Key.font : UIFont.bold.withSize(16), NSAttributedString.Key.foregroundColor : UIColor.black] as [NSAttributedString.Key : Any]
        return NSMutableAttributedString(string: self, attributes: attrsRegular)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toDate(dateFormat: String = "yyyy-MM-dd") -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
    
}
