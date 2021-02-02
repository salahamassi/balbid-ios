//
//  AddNewShippingViewController.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit

class
AddNewShippingViewController: BaseViewController {

    @IBOutlet weak var noteTextView: UITextView!

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
    
}
