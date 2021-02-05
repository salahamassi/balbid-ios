//
//  AppRealTimeDataSource.swift
//  MSA
//
//  Created by Salah Amassi on 06/02/2021.
//

import Foundation

final class AppRealTimeDataSource: DataSource {

    typealias DataSourceServiceType = RealTimeDataSourceService

    let realTime: RealTime

    init(realTime: RealTime) {
        self.realTime = realTime
    }

    func perform(service: RealTimeDataSourceService, completion: DataSourceCompletion?) {
        switch service.opreationType {
        case .add:
            realTime.add(to: service.path, childByAutoId: service.childByAutoId, params: service.params, completion: completion)
        case .update:
            realTime.update(at: service.path, params: service.params, completion: completion)
        case .delete:
            realTime.delete(at: service.path, completion: completion)
        case .get:
            realTime.get(from: service.path,
                         limit: service.limit,
                         orderedBy: service.key,
                         startingAt: service.startingValue,
                         queryEqual: service.queryEqual,
                         completion: completion)
        case .observeChildAdded:
            realTime.observeChildAdded(at: service.path, limit: service.limit, completion: completion)
        case .observeChildUpdated:
            realTime.observeChildUpdated(at: service.path, completion: completion)
        case .observeChildDeleted:
            realTime.observeChildDeleted(at: service.path, completion: completion)
        case .observeValueChanged:
            realTime.observeValueChanged(at: service.path, completion: completion)
        }
    }
}
