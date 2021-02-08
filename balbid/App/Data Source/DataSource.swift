//
//  DataSource.swift
//  MSA
//
//  Created by Salah Amassi on 4/21/20.
//  Copyright © 2020 winch. All rights reserved.
//

import MOLH
import Foundation

enum DataSourceResult<T: SwiftyModelData> {
    case success(_ result: T)
    case data(_ data: BaseModel<T>)
    case failure(_ error: String)
}

// MARK: - DataSourceCompletion
typealias DataSourceCompletion = ((_ result: Data?, _ error: LLError?) -> Void)
typealias BalbildDataSourceCompletion<T: SwiftyModelData> = ((_ result: DataSourceResult<T>) -> Void)

// MARK: - DataSource
protocol DataSource {
    associatedtype DataSourceServiceType

    @available(*, deprecated, message: "Use perform function with BalbildDataSourceCompletion instead")
    func perform(service: DataSourceServiceType, completion: DataSourceCompletion?)

    func perform<T: SwiftyModelData>(service: DataSourceServiceType, _ type: T.Type, completion: BalbildDataSourceCompletion<T>?)
}

extension DataSource {

    func perform<T: SwiftyModelData>(service: DataSourceServiceType, _ type: T.Type, completion: BalbildDataSourceCompletion<T>?) {

    }
}
