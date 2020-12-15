//
//  AccountOptionViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 15/12/2020.
//

import UIKit

class AccountOptionViewController: BaseViewController {

    @IBOutlet weak var companyOptionView: AccountOptionView!
    @IBOutlet weak var individualOptionView: AccountOptionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func setAccountOption(_ sender: UIButton) {
        companyOptionView.isSet = sender.tag == 1
        individualOptionView.isSet = sender.tag == 0
    }
    
    
    
}
