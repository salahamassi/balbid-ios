//
//  ProductTrackViewController.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit

class ProductTraceViewController: BaseViewController {
    
    @IBOutlet weak var binCodeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupPinCodeLabelText()
    }
    
    private func setupNavbar(){
        self.title = "#9254112114455141"
    }
    
    private func setupPinCodeLabelText(){
        let mainText = (binCodeLabel.text!.components(separatedBy: ":")[0] + ":")
        .convertToMutableAttributedString(with: UIFont.regular.withSize(12), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  binCodeLabel.text!.components(separatedBy: ":")[1].convertToAttributedString(with: UIFont.bold.withSize(12), and: #colorLiteral(red: 0.8039215686, green: 0.1921568627, blue: 0.1333333333, alpha: 1))
        mainText.append(secondaryText)
        binCodeLabel.attributedText = mainText
    }
    
    @IBAction func goToRateController(_ sender: Any){
        router?.navigate(to: .productRatingRoute)
    }
    
    @IBAction func goToMapTraceController(_ sender: Any){
        router?.navigate(to: .orderTraceMapRoute)
    }
    

}
