//
//  Extension+String+FileType.swift
//  balbid
//
//  Created by Qamar Nahed on 24/12/2020.
//

import Foundation
extension String {
    func getFileIconFromName() -> String? {
        if  components(separatedBy: ".").count  < 1 {
            return "unknown"
        }
        let type = components(separatedBy: ".")[components(separatedBy: ".").count - 1]
        switch type {
        case "doc", "docx" :
            return "word"
        case "pdf" :
            return "pdf"
        case "png", "jpg", "jpeg" :
            return nil
        default  :
            return "unknown"
        }
    }
}
