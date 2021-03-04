//
//  Observable.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import UIKit

class Observable<ObservedType> {
    private var _value : ObservedType?
    
    var valueChanged : ((ObservedType?) -> Void)?
    
    init(value : ObservedType) {
        self._value = value
    }

    
    public var value : ObservedType? {
        set{
           _value = newValue
           valueChanged?(newValue)
        }
        
        get {
            return _value
        }
    }
    
    func bindingChanged(newValue : ObservedType){
        value = newValue
    }

}
