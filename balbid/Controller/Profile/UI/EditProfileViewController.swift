//
//  EditProfileViewController.swift
//  balbid
//
//  Created by Memo Amassi on 23/01/2021.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    @IBOutlet var twoColorLabel: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupTwoColorLabels()
    }
    
    private  func setupNavbar(){
        self.title = "Edit Profile"
        (self.navigationController as! AppNavigationController).restyleBackButton()
    }

    private func setupTwoColorLabels(){
        twoColorLabel.forEach { (label) in
            self.changeColorLabel(with: label.text!, label: label)
        }
    
    }
    
    private func changeColorLabel(with text: String, label: UILabel){
        let mainText = (text.components(separatedBy: ":")[0] + ": ")
        .convertToMutableAttributedString(with: UIFont.medium.withSize(12), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  text.components(separatedBy: ":")[0].convertToAttributedString(with: UIFont.regular.withSize(14), and: #colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1))
        mainText.append(secondaryText)
        label.attributedText = mainText
    }
    
}
