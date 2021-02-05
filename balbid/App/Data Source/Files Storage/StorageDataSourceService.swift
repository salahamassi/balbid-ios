//
//  StorageDataSourceService.swift
//  MSA
//
//  Created by Salah Amassi on 06/02/2021.
//

import Foundation

struct StorageDataSourceService: DataSourceService {

    let path: String
    var file: Data
    var contentType: String?

    init(path: String, file: Data, contentType: String? = nil) {
        self.path = path
        self.file = file
        self.contentType = contentType
    }
}
