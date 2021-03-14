//
//  CreateOrderViewModel.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit

class CreateOrderViewModel: NSObject {
    weak var delegate: CreateOrderViewModelDelegate?
    let dataSource: AppDataSource
    
     init(dataSource: AppDataSource) {
        self.dataSource = dataSource
    }
    
    func addNewOrder(addressId: Int, paymentMethodId: Int, transactionNumber: String?, transactionImage: URL?) {
        var params: [String: Any] = ["customer_address_id": addressId, "payment_method_id": paymentMethodId]
        var files: [String: URL] = [:]

        if(transactionNumber != nil){
            params["transaction_no"] = transactionNumber
        }
        
        if(transactionImage != nil) {
            files["statement"] = transactionImage
        }
        
        dataSource.perform(service: .init(path: .addOrderPath, domain: .domain, method: .post, params: params,files: files, mustUseAuth: true), Cart.self) { (result) in
            switch result {
            case .data(_):
                self.delegate?.didAddOrderSuccess()
                self.deleteUploadedFile(transactionImage: transactionImage)
            case .failure(let error):
                self.delegate?.apiError(error: error)
            default:
                break
            }
        }
        
    }

    func deleteUploadedFile(transactionImage: URL?) {
        do {
             let fileManager = FileManager.default
            
            // Check if file exists
            if fileManager.fileExists(atPath: transactionImage?.absoluteURL.path ?? "") {
                // Delete file
                try fileManager.removeItem(atPath: transactionImage?.absoluteURL.path ?? "")
            } else {
                print("File does not exist")
            }
         
        }
        catch let error as NSError {
            print("An error took place: \(error)")
        }

    }
    
    
}

protocol CreateOrderViewModelDelegate: class {
    func apiError(error: String)
    func didAddOrderSuccess()
}
