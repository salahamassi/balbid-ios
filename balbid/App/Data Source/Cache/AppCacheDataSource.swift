//
//  AppCacheDataSource.swift
//  MSA
//
//  Created by Salah Amassi on 30/12/2020.
//  Copyright © 2020 winch. All rights reserved.
//

import SwiftyJSON

final class AppCacheDataSource: DataSource {
    
    typealias DataSourceServiceType = CacheDataSourceService
    
    let cache: Cache
    
    init(cache: Cache) {
        self.cache = cache
    }
    
    func perform(service: CacheDataSourceService, completion: DataSourceCompletion?) {
        switch service.opreationType {
        case .add:
            let data = cache.add(path: service.path, data: service.data)
            completion?(data, nil)
        case .get:
            completion?(cache.get(path: service.path), nil)
        case .delete:
            completion?(cache.delete(path: service.path), nil)
        }
    }
    
    func get<T: SwiftyModelData>(path: String, _ type: T.Type) -> T? {
        guard let data = cache.get(path: path), data.count > 0 else { return nil }
        return BaseModel<T>(json: JSON(data)).data
    }
}
