//
//  AppNetworkDataSource.swift
//  MSA
//
//  Created by Salah Amassi on 20/12/2020.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

final class AppNetworkApiDataSource: DataSource {
    
    typealias DataSourceServiceType = NetworkApiDataSourceService
    
    let networkApi: NetworkApi
    
    init(networkApi: NetworkApi) {
        self.networkApi = networkApi
    }
    
    func perform(service: NetworkApiDataSourceService, completion: DataSourceCompletion?) {
        networkApi.request(url: service.domain + service.path, method: service.method, params: service.params, files: service.files, headers: getHeaders(mustUseAuth: service.mustUseAuth), completion: completion)
    }
    
    func perform<T: SwiftyModelData>(service: NetworkApiDataSourceService, _ type: T.Type, completion: BalbildDataSourceCompletion<T>?) {
        networkApi.request(url: service.domain + service.path, method: service.method, params: service.params, files: service.files, headers: getHeaders(mustUseAuth: service.mustUseAuth)) { [weak self] (data, error) in
            guard let self = self else { return }
            self.handleData(data, error, type, for: service, completion: completion)
        }
    }
    
    func handleData<T: SwiftyModelData>(_ data: Data?, _ error: LLError?, _ type: T.Type, for service: NetworkApiDataSourceService, completion: BalbildDataSourceCompletion<T>?) {
        if let data = data{
            handleData(data, type, for: service, completion: completion)
        }else if let error = error{
            completion?(.failure(error.message))
        }else{
            completion?(.failure("keyword.unknownError".localized))
        }
    }
    
    func handleData<T: SwiftyModelData>(_ data: Data, _ type: T.Type, for service: NetworkApiDataSourceService, completion: BalbildDataSourceCompletion<T>?) {
        let result = BalbildParser.parse(data: data, type)
        switch result{
        case .data(let data):
            completion?(.data(data))
        case .failure(let error):
            completion?(.failure(error))
        }
    }
    //
    private func getHeaders(mustUseAuth: Bool) -> [String: String] {
        var headers: [String: String]
        headers = [
            "X-localization": UserDefaultsManager.appLanguage ?? "en",
            "brand-id": "5",
            "channel": "app"
        ]
        if let token = UserDefaultsManager.token, mustUseAuth {
            headers["api-token"] = "\(token)"
        }
        return headers
    }
}
