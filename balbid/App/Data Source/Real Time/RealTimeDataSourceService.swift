//
//  RealTimeDataSourceService.swift
//  MSA
//
//  Created by Salah Amassi on 06/02/2021.
//

import Foundation

struct RealTimeDataSourceService: DataSourceService {

    let path: String
    let opreationType: RealTimeOpreationType
    let params: [String: Any]?
    let limit: Int?
    let key: String?
    let startingValue: Any?
    let childByAutoId: Bool
    let queryEqual: (toValue: Any, childKey: String)?
    
    init(path: String,
                opreationType: RealTimeOpreationType,
                params: [String: Any]? = nil,
                limit: Int? = nil,
                orderedBy key: String? = nil,
                startingValue: Any? = nil,
                queryEqual: (toValue: Any, childKey: String)? = nil,
                childByAutoId: Bool = false) {
        self.path = path
        self.opreationType = opreationType
        self.params = params
        self.limit = limit
        self.key = key
        self.startingValue = startingValue
        self.queryEqual = queryEqual
        self.childByAutoId = childByAutoId
    }
}
