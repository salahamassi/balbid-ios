//
//  CategoriesViewModel.swift
//  balbid
//
//  Created by Apple on 16/02/2021.
//

import UIKit

class CategoriesViewModel: NSObject {
    
    let dataSource: AppDataSource
    weak var delegate: CategoriesViewModelDelegate?
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func getCategries() {
        dataSource.perform(service: .init(path: .categoryPath, domain: .domain, method: .get, params: [:], mustUseAuth: true), Category.self) { (result) in
            switch result {
            case .data(let data):
                self.delegate?.loadCategoriesSuccess(category: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }

    
    
}


protocol CategoriesViewModelDelegate: class {
    func apiError(error: String)
    func loadCategoriesSuccess(category: Category)
}
