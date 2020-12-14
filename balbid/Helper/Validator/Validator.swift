//
//  Validator.swift
//  MSA
//
//  Created by Salah Amassi on 13/12/2019.
//

import UIKit

final class Validator{
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private var boolArray = [Bool]()
    
    func validate(_ view: UIView?, with condition: Bool, errorMessage: String? = nil){
        viewController?.view?.endEditing(true)
        boolArray.append(condition)
        let failureArray = boolArray.filter { (isValidate) -> Bool in
            return !isValidate
        }
        //   if failureArray.count > 1 { return }
        if !condition{
            if let errorMessage = errorMessage{
                if failureArray.count == 1{
                    viewController?.displayAlert(message: errorMessage)
                }
            }
            view?.animateBorder(with: .red, border: 0.5)
        }else{
            view?.animateBorder(with: .clear)
        }
    }
    
    public func validateAll() -> Bool{
        let successArray = boolArray.filter { (isValidate) -> Bool in
            return isValidate
        }
        
        return successArray.count == boolArray.count
    }
}
