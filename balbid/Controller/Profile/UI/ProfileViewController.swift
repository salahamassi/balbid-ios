//
//  ProfileViewController.swift
//  balbid
//
//  Created by Memo Amassi on 23/01/2021.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var logoutArrowImageView: UIImageView!
    @IBOutlet weak var logoutActivityIndicator: UIActivityIndicatorView!
    
    var profileViewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupviewModel()

        // Do any additional setup after loading the view.
    }
    
    private func setupviewModel(){
        let dataSource = AppDataSource()
        profileViewModel = ProfileViewModel(dataSource: dataSource)
        profileViewModel.delegate = self
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
    
    @IBAction func gotoCreditBalanceController(_ sender: Any){
        router?.navigate(to: .creditBalanceRoute)
    }
    
    @IBAction func gotoPaymentCardController(_ sender: Any){
        router?.navigate(to: .paymentCardRoute)
    }

    
    @IBAction func logout(_ sender: Any){
        logoutActivityIndicator.startAnimating()
        logoutArrowImageView.isHidden = true
        profileViewModel.logout()
    }


}

extension ProfileViewController: ProfileViewModelDelegate {
    func apiError(error: String) {
        logoutActivityIndicator.stopAnimating()
        logoutArrowImageView.isHidden = false
        displayAlert(message: error)
    }
    
    func logoutSuccess() {
        logoutActivityIndicator.stopAnimating()
        logoutArrowImageView.isHidden = false
        router?.navigate(to: .mainTabBarRoute)
    }
    
    
}
