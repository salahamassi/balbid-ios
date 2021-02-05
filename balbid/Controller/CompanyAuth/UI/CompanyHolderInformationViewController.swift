//
//  companyHolderInforamtionViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit

class CompanyHolderInformationViewController: BaseViewController {

    let releaseDatePicker: UIDatePicker = UIDatePicker()
    let endDatePicker: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        // Do any additional setup after loading the view.
    }

    func setDatePicker() {
        releaseDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date

        releaseDateTextField.inputView = releaseDatePicker
        endDateTextField.inputView = endDatePicker

        releaseDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }

    @objc
    func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
           if let day = components.day, let month = components.month, let year = components.year {
            if sender == endDatePicker {
                endDateTextField.text = "\(day) \(month) \(year)"
            } else {
                releaseDateTextField.text = "\(day) \(month) \(year)"
            }
           }
    }

}
