//
//  ProductDetailRateViewModel.swift
//  balbid
//
//  Created by Apple on 28/02/2021.
//

import Foundation


struct ProductDetailRateViewModel {
    
    let dataSource: AppDataSource
    weak var delegate:  ProductDetailRateViewModelDelegate?
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func getProductEvaluation(id: Int){
        dataSource.perform(service: .init(path: .productEvaluationPath + "\(id)" + "&page=1&paginate=10", domain: .domain, method: .get, params: [:], mustUseAuth: true), EvaluationItem.self) { (result) in
            switch result {
            case .data(let data):
                print(data.data)
                self.delegate?.didLoadEvalutionSuccess(evaluation: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }

}

protocol ProductDetailRateViewModelDelegate: class {
    func apiError(error: String)
    func didLoadEvalutionSuccess(evaluation: EvaluationItem)
    
}
