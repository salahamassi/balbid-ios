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
    var isLoggedIn: Bool!
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
        isLoggedIn = UserDefaultsManager.token != nil
    }
    
    private func setupView(){
        logLabel.text = UserDefaultsManager.token == nil ? "Login" : "Logout"
    }
    
    
    @IBAction func gotoEditProfileController(_ sender: Any){
        if isLoggedIn {
            router?.navigate(to: .editProfileRoute)
        }else {
            loginAlert()
        }
    }
    
    @IBAction func gotoPointController(_ sender: Any){
        router?.navigate(to: .pointRoute)
    }
    
    @IBAction func gotoUserOrderController(_ sender: Any){
        router?.navigate(to: .userOrderRoute)
    }
    
    @IBAction func gotoFavoriteController(_ sender: Any){
        if isLoggedIn {
            router?.navigate(to: .favoriteRoute)
        }  else{
            loginAlert()
        }
    }
    
    @IBAction func gotoShippingAddressesController(_ sender: Any){
        if isLoggedIn {
            router?.navigate(to: .shippingAddressRoute)
        }  else{
            loginAlert()
        }
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
