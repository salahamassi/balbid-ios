//
//  AppDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 06/02/2021.
//

import Foundation

class AppDataSource {
    
    private let appNetworkDataSource: AppNetworkApiDataSource
    private let appCacheDataSource: AppCacheDataSource
    private let appDownloadFiles: AppDownloadFiles
    
    public init(appNetworkDataSource: AppNetworkApiDataSource = AppNetworkApiDataSource(networkApi: AlamofireNetworkApi()),
                appCasheDataSource: AppCacheDataSource = AppCacheDataSource(cache: UserDefaultsCache()),
                appDownloadFiles: AppDownloadFiles = AppDownloadFiles(fileDownload: AlamofireFileDownload())) {
        self.appNetworkDataSource = appNetworkDataSource
        self.appCacheDataSource = appCasheDataSource
        self.appDownloadFiles = appDownloadFiles
    }
    
    @available(*, deprecated, message: "Use perform function with WinchDataSourceCompletion instead")
    public func perform(service: NetworkApiDataSourceService, completion: DataSourceCompletion?) {
        if ReachabilityManager.shared.isNetworkReachable {
            if service.mustCaching {
                appNetworkDataSource.perform(service: service, completion: networkDataSourceServiceCompletion(service, completion))
            } else {
                appNetworkDataSource.perform(service: service, completion: completion)
            }
        } else {
            let cacheDataSourceService = generateCacheDataSourceService(service, opreationType: .get)
            perform(service: cacheDataSourceService, completion: completion)
        }
    }
    
    /// perform service with completion: nil
    /// - Parameter service: network service need to fetch
    public func perform(service: NetworkApiDataSourceService) {
        if ReachabilityManager.shared.isNetworkReachable {
            if service.mustCaching {
                appNetworkDataSource.perform(service: service, completion: networkDataSourceServiceCompletion(service))
            } else {
                appNetworkDataSource.perform(service: service, completion: nil)
            }
        }
    }
    
    /// perform service and return result with specfice type using completion
    /// - Parameters:
    ///   - service: network service need to fetch
    ///   - type: type of expected result
    ///   - completion: function will send a result after service performed
    public func perform<T: SwiftyModelData>(service: NetworkApiDataSourceService, _ type: T.Type, completion: BalbildDataSourceCompletion<T>?) {
        if ReachabilityManager.shared.isNetworkReachable {
            if service.mustCaching {
                appNetworkDataSource.perform(service: service, completion: networkDataSourceServiceCompletion(service, type, completion))
            } else {
                appNetworkDataSource.perform(service: service, type, completion: completion)
            }
        } else {
            getFromCache(service, type, completion: completion)
        }
    }
    
    /// get object of T from Cache If it exists
    /// - Parameters:
    ///   - path: where data stored
    ///   - winchData: true if data from winch api
    ///   - type: type of expected result
    /// - Returns: result if exist
    public func getFromCache<T: SwiftyModelData>(path: String,_ type: T.Type) -> T? {
        return appCacheDataSource.get(path: path, type)
    }
    
    /// perform cache service
    /// - Parameters:
    ///   - service: Cache service need to fetch
    ///   - completion: no need to completion always send nil
    public func perform(service: CacheDataSourceService, completion: DataSourceCompletion?) {
        appCacheDataSource.perform(service: service, completion: completion)
    }
    
    /// perform service to download data
    /// - Parameters:
    ///   - service: download service need to fetch
    ///   - completion: function will send downloaded data
    public func perform(service: DownloadDataSourceService, completion: DataSourceCompletion?) {
        appDownloadFiles.perform(service: service, completion: completion)
    }
    
    /// helper function to get data from cache and send it to network service completion
    /// - Parameters:
    ///   - service: network service need it to get data from cache
    ///   - type: type of expected result
    ///   - completion: function will send result
    private func getFromCache<T: SwiftyModelData>(_ service: NetworkApiDataSourceService, _ type: T.Type, completion: BalbildDataSourceCompletion<T>?){
        if let data = appCacheDataSource.get(path: service.cachePath == nil ? service.path : service.cachePath!, type){
            completion?(.data(.init(success: true, data: data, message: "")))
        }else{
            completion?(.failure("keyword.unknownError".localized))
        }

    }
    
    /// helper function used to generate cache service from network service
    /// - Parameters:
    ///   - service: network service used to generate cache service
    ///   - opreationType: type of opreation in cache service add or delete
    ///   - data: if there are data need to add
    /// - Returns: a generated cache service
    private func generateCacheDataSourceService(_ service: NetworkApiDataSourceService, opreationType: CacheOpreationType, data: Data? = nil) -> CacheDataSourceService {
        return CacheDataSourceService(path: service.cachePath == nil ? service.path : service.cachePath!, opreationType: opreationType, data: data)
    }
    
    /// helper function used to customized DataSourceCompletion for network service, we need to store a result from network service in cache.
    /// - Parameters:
    ///   - service: network service that performed
    ///   - type: type of expected result
    ///   - completion: function will send result to orignal caller
    /// - Returns: a customized block of DataSourceCompletion
    private func networkDataSourceServiceCompletion<T>(_ service: NetworkApiDataSourceService, _ type: T.Type, _ completion: BalbildDataSourceCompletion<T>?) -> DataSourceCompletion {
        return { [weak self] (data, error) in
            guard let self = self else { return }
            if let data = data{
                let cacheService = self.generateCacheDataSourceService(service, opreationType: .add, data: data)
                self.perform(service: cacheService, completion: nil)
                self.appNetworkDataSource.handleData(data, type, for: service, completion: completion)
            }else{
                self.getFromCache(service, type, completion: completion)
            }
        }
    }
    
    /// helper function used to store a result from network service to cache
    /// - Parameter service: network service
    /// - Returns: network data source Completion
    private func networkDataSourceServiceCompletion(_ service: NetworkApiDataSourceService) -> DataSourceCompletion {
        return { [weak self] (data, error) in
            guard let self = self else { return }
            if let data = data, data.count > 0 {
                let cacheDataSourceService = self.generateCacheDataSourceService(service, opreationType: .add, data: data)
                self.perform(service: cacheDataSourceService, completion: nil)
            }
        }
    }
    
    @available(*, deprecated, message: "Use perform function with WinchDataSourceCompletion instead")
    private func networkDataSourceServiceCompletion(_ service: NetworkApiDataSourceService, _ completion: DataSourceCompletion?) -> DataSourceCompletion {
        return { [weak self] (data, error) in
            completion?(data, error)
            guard let self = self else { return }
            if error != nil {
                let cacheDataSourceService = self.generateCacheDataSourceService(service, opreationType: .get)
                self.perform(service: cacheDataSourceService, completion: completion)
            } else if let data = data {
                let cacheDataSourceService = self.generateCacheDataSourceService(service, opreationType: .add, data: data)
                self.perform(service: cacheDataSourceService, completion: nil)
            } else {
                let cacheDataSourceService = self.generateCacheDataSourceService(service, opreationType: .get)
                self.perform(service: cacheDataSourceService, completion: completion)
            }
        }
    }
}
