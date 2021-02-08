//
//  CacheDataSourceService.swift
//  MSA
//
//  Created by Salah Amassi on 30/12/2020.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

struct CacheDataSourceService: DataSourceService {

    let path: String
    let opreationType: CacheOpreationType
    let data: Data?

    init(path: String, opreationType: CacheOpreationType, data: Data? = nil) {
        self.path = path
        self.opreationType = opreationType
        self.data = data
    }
}
