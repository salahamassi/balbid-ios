//
//  BindingTextField.swift
//  balbid
//
//  Created by Apple on 04/03/2021.
//

import UIKit

import UIKit


class BindingTextField: UITextField {
    var changedClosure : (() -> ())?
    func bind(to observable : Observable<String>){
        self.text = observable.value
        addTarget(self, action: #selector(BindingTextField.textFieldDidChanged), for: .editingChanged)
        changedClosure = {[weak self] in
            guard let path = self?.text   else {
                return
            }
            observable.bindingChanged(newValue:path )
        }
        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
    
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        changedClosure?()
    }
}
