//
//  ProductDetailRateViewModel.swift
//  balbid
//
//  Created by Apple on 28/02/2021.
//

import Foundation


class ProductDetailRateViewModel {
    
    let dataSource: AppDataSource
    weak var delegate:  ProductDetailRateViewModelDelegate?
    var evaluation: EvaluationItem!
    var pageNumber: Int = 1
    
    init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
     func getProductEvaluation(id: Int){
        dataSource.perform(service: .init(path: .productEvaluationPath + "\(id)" + "&page=\(pageNumber)&paginate=10", domain: .domain, method: .get, params: [:], mustUseAuth: true), EvaluationItem.self) { (result) in
            switch result {
            case .data(let data):
                self.evaluation = data.data
                self.delegate?.didLoadEvalutionSuccess(evaluation: data.data)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
    }
    
    func avgRate() -> Double {
        Double(evaluation.evaluateAvg) ?? 0
    }
    
    func firstRateValue() -> Float {
        if  (Float(evaluation.evaluateCount) == 0) {
            return 0
        }
        return (Float(evaluation.rating1) ?? 0) /  (Float(evaluation.evaluateCount) ?? 0)
    }
    
    func secondRateValue() -> Float {
        if  (Float(evaluation.evaluateCount) == 0) {
            return 0
        }
        return (Float(evaluation.rating2) ?? 0) /  (Float(evaluation.evaluateCount) ?? 0)
    }
    
    func thirdRateValue() -> Float {
        if  (Float(evaluation.evaluateCount) == 0) {
            return 0
        }
        return (Float(evaluation.rating3) ?? 0) /  (Float(evaluation.evaluateCount) ?? 0)
    }
    
    func fourthRateValue() -> Float {
        if  (Float(evaluation.evaluateCount) == 0) {
            return 0
        }
        return (Float(evaluation.rating4) ?? 0) /  (Float(evaluation.evaluateCount) ?? 0)
    }
    
    func fifthRateValue() -> Float {
        if  (Float(evaluation.evaluateCount) == 0) {
            return 0
        }
        return (Float(evaluation.rating5) ?? 0) /  (Float(evaluation.evaluateCount) ?? 0)
    }

}

protocol ProductDetailRateViewModelDelegate: class {
    func apiError(error: String)
    func didLoadEvalutionSuccess(evaluation: EvaluationItem)
    
}
