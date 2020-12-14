//
//  Extensions+UIFont.swift
//  MSA
//
//  Created by Salah Amassi on 10/27/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UIFont{
    
    static var regular: UIFont{
        get{
            if Locale.current.languageCode == "ar"{
                return UIFont.systemFont(ofSize: 15)
            }else{
                return UIFont(name: "Roboto-Regular", size: 15)!
            }
        }
    }
    
    static var bold: UIFont{
        get{
            if Locale.current.languageCode == "ar"{
                return UIFont.boldSystemFont(ofSize: 15)
            }else{
                return UIFont(name: "Roboto-Bold", size: 15)!
            }
        }
    }
    
    static var medium: UIFont{
        get{
            if Locale.current.languageCode == "ar"{
                return UIFont.boldSystemFont(ofSize: 15)
            }else{
                return UIFont(name: "Roboto-Medium", size: 15)!
            }
        }
    }

}
