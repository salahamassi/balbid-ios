//
//  CreateOrderViewModel.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit

class CreateOrderViewModel: NSObject {

    
    
}

protocol CreateOrderViewModelDelegate: class {
    func apiError(error: String)
    func didAddOrderSuccess()
}
