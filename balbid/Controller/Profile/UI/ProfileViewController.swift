//
//  ProfileViewController.swift
//  balbid
//
//  Created by Memo Amassi on 23/01/2021.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func gotoEditProfileController(_ sender: Any){
        router?.navigate(to: .editProfileRoute)
    }
    
    @IBAction func gotoPointController(_ sender: Any){
        router?.navigate(to: .pointRoute)
    }
    
    @IBAction func gotoUserOrderController(_ sender: Any){
        router?.navigate(to: .userOrderRoute)
    }
    
    @IBAction func gotoFavoriteController(_ sender: Any){
        router?.navigate(to: .favoriteRoute)
    }
    
    @IBAction func gotoShippingAddressesController(_ sender: Any){
        router?.navigate(to: .shippingAddressRoute)
    }


}
