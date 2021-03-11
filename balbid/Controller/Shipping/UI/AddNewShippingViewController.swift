//
//  AddNewShippingViewController.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit

class
AddNewShippingViewController: BaseViewController {

    @IBOutlet weak var cityTextField: BorderedTextField!
    @IBOutlet weak var nameTextField: BorderedTextField!
    @IBOutlet weak var noteTextView: TextViewWithHint!
    @IBOutlet weak var countryTextField: BorderedTextField!
    @IBOutlet weak var phoneNumberTextField: BorderedTextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var neighborhoodTextField: BorderedTextField!
    @IBOutlet weak var familyTextField: BorderedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
    }

    
    private func setupNav(){
        title = "Add New Address"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupView(){
        noteTextView.contentInset = UIEdgeInsets.allSides(16)
    }
    
    @IBAction func showMapController(_ sender: Any) {
        router?.navigate(to: .shippingMapRoute)
    }
    
    @IBAction func save(_ sender: Any) {
    }
}
