//
//  DownloadDataSourceService.swift
//  MSA
//
//  Created by Salah Amassi on 06/02/2021.
//

import Foundation

struct DownloadDataSourceService: DataSourceService {

    let path: String
    var name: String?
    var fileExtenstion: String?

    init(path: String, name: String?, fileExtenstion: String?) {
        self.name = name
        self.path = path
        self.fileExtenstion = fileExtenstion
    }
}
