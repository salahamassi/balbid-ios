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
    @IBOutlet weak var logLabel: UILabel!
    
    var profileViewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupviewModel()
        setupView()
    }
    
    private func setupviewModel(){
        let dataSource = AppDataSource()
        profileViewModel = ProfileViewModel(dataSource: dataSource)
        profileViewModel.delegate = self
    }
    
    private func setupView(){
        logLabel.text = UserDefaultsManager.token == nil ? "Login" : "Logout"
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
        if(UserDefaultsManager.token != nil){
            logoutActivityIndicator.startAnimating()
            logoutArrowImageView.isHidden = true
            profileViewModel.logout()
        }else{
            router?.navigate(to: AuthRoutes.loginOptionRoute(transitioningDelegate: nil))
        }
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
        router?.navigate(to: AuthRoutes.loginOptionRoute(transitioningDelegate: nil))
        setupView()
    }
    
    
}
