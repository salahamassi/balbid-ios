//
//  AlamofireNetworkDataSource.swift
//  MSA
//
//  Created by Salah Amassi on 4/23/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation
import Alamofire

final class AlamofireNetworkApi: NetworkApi {
    
    init() {
        AF.sessionConfiguration.timeoutIntervalForRequest = 5000
        AF.sessionConfiguration.timeoutIntervalForResource = 5000
    }
    
    func request(url: String, method: String, params: [String: Any?], files: [String: URL]?, headers: [String: String], completion: DataSourceCompletion?) {
        let httpMethod = HTTPMethod.init(rawValue: method)
        let encoding: ParameterEncoding
        if httpMethod == .get{
            encoding = URLEncoding.default
        }else{
            encoding = JSONEncoding.default
        }
        var alamofireHeaders = HTTPHeaders()
        for header in headers{
            alamofireHeaders.add(HTTPHeader(name: header.key, value: header.value))
        }
        
        if let files = files{
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                    guard let value = value else { continue }
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                for file in files{
                    do {
                        let data = try Data(contentsOf: file.value)
                        multipartFormData.append(data, withName: file.key, fileName: file.value.lastPathComponent, mimeType: data.mimeType)
                    }catch{
                        print(error.localizedDescription)
                        continue
                    }
                }
            }, to: url, method: httpMethod , headers: alamofireHeaders)
            .response { response in
                if let error = response.error {
                    completion?(nil, .init(message: error.errorDescription ?? "keyword.unknownError".localized))
                }else  if let data = response.data {
                    completion?(data, nil)
                }else {
                    completion?(nil, .init(message: "keyword.unknownError".localized))
                }
            }
        }else{
            let request = AF.request(url, method: httpMethod, parameters: params as Parameters, encoding: encoding, headers: alamofireHeaders, interceptor: nil, requestModifier: nil)
            request.responseString { (response) in
                if let error = response.error {
                    completion?(nil, .init(message: error.errorDescription ?? "keyword.unknownError".localized))
                }else  if let data = response.data {
                    completion?(data, nil)
                }else {
                    completion?(nil, .init(message: "keyword.unknownError".localized))
                }
            }
        }
    }
}
