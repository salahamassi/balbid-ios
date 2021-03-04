//
//  MainCompanyAuthViewModel.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class MainCompanyAuthViewModel: NSObject {

    
    var params: [String: Any] = [:]
    
    var dataSource: AppDataSource?
    weak var delegate: MainCompanyAuthViewModelDelegate?
    
    class var sharedManger: MainCompanyAuthViewModel {
        struct Static {
            static let mainCompanyAuthViewModel = MainCompanyAuthViewModel()
        }
        return Static.mainCompanyAuthViewModel
    }
    
     func addNewCorporate() {
        dataSource?.perform(service: .init(path: .corporateStorePath, domain: .domain, method: .post, params:MainCompanyAuthViewModel.sharedManger.params), User.self) { (result) in
            switch result {
              case .data(let data):
                let user = data.data as User
                UserDefaultsManager.token = user.apiToken
                self.delegate?.didAddCorporateSuccess()
              case .failure(let error):
                self.delegate?.apiError(error: error)
              default:
                break
            }
        }
    }
    
}

protocol MainCompanyAuthViewModelDelegate: class {
    func apiError(error: String)
    func didAddCorporateSuccess()

}
