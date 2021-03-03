//
//  MainCompanyAuthViewModel.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class MainCompanyAuthViewModel: NSObject {

    
    var params: [String: Any] = [:]
    
    class var sharedManger: MainCompanyAuthViewModel {
        struct Static {
            static let mainCompanyAuthViewModel = MainCompanyAuthViewModel()
        }
        return Static.mainCompanyAuthViewModel
    }
    
    
    
}
