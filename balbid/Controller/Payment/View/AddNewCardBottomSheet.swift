//
//  AddNewCardBottomSheet.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class AddNewCardBottomSheet: BottomSheetView {
    
    @IBOutlet weak var expireDateTextField: BorderedTextField!
    
    private let expireDatePicker = UIDatePicker()
    
    override class func initFromNib() -> AddNewCardBottomSheet {
        return Bundle.init(for: AddNewCardBottomSheet.self).loadNibNamed(.addNewCardBottomSheet, owner: self, options: nil)!.first as! AddNewCardBottomSheet
    }
    
    override func awakeFromNib() {
        viewHeight = 368
        super.awakeFromNib()
    }
    
    internal override func setupSheetView() {
        super.setupSheetView()
        expireDateTextField.inputView = expireDatePicker
        expireDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc
    func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
           if let day = components.day, let month = components.month, let year = components.year {
                expireDateTextField.text = "\(day) /\(month)/\(year)"
        }
    }
}
