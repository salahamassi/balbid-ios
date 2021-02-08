//
//  HomeViewModel.swift
//  balbid
//
//  Created by Memo Amassi on 08/02/2021.
//

import UIKit

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    let dataSource: AppDataSource
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func getHomeData(){
        dataSource.perform(service: .init(path: .homePath, domain: .domain, method: .get, params: [:]), Home.self) { (result) in
            switch result {
              case .data(let data):
                print(data)
                self.delegate?.loadHomeSuccess()
              case .failure(let error):
                self.delegate?.apiError(error: error)
              default:
                break
            }
        }
    }

}


protocol HomeViewModelDelegate: class {
    func loadHomeSuccess()
    func apiError(error: String)

}
