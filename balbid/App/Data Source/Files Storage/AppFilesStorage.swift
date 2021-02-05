//
//  AppFilesStorage.swift
//  MSA
//
//  Created by Salah Amassi on 06/02/2021.
//

class AppFilesStorage: DataSource {

    typealias DataSourceServiceType = StorageDataSourceService

    let filesStorage: FilesStorage

    init(filesStorage: FilesStorage) {
        self.filesStorage = filesStorage
    }

    func perform(service: DataSourceServiceType, completion: DataSourceCompletion?) {
        filesStorage.upload(path: service.path, file: service.file, contentType: service.contentType, completion: completion)
    }
}
