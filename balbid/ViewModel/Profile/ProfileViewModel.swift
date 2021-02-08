//
//  ProfileViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 07/02/2021.
//

import UIKit

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    let dataSource: AppDataSource

    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func logout(){
        print("logout")
        dataSource.perform(service: .init(path: .logoutPath, domain: .domain, method: .post, params: [:], mustUseAuth: true), User.self) { (result) in
            switch result {
              case .data(_):
                print("Data")
                UserDefaultsManager.token = nil
                self.delegate?.logoutSuccess()
              case .failure(let error):
                print(error)

                self.delegate?.apiError(error: error)
              default:
                print("I am default")
                break
            }
        }
    }
}


protocol ProfileViewModelDelegate: class {
    func apiError(error: String)
    func logoutSuccess()

}
