//
//  AppDownloadFiles.swift
//  MSA
//
//  Created by Salah Amassi on 06/02/2021.
//

import Foundation

class AppDownloadFiles: DataSource {

   typealias DataSourceServiceType = DownloadDataSourceService

   let fileDownload: FileDownload

   init(fileDownload: FileDownload) {
       self.fileDownload = fileDownload
   }

   func perform(service: DownloadDataSourceService, completion: DataSourceCompletion?) {
       fileDownload.download(path: service.path, name: service.name, extention: service.fileExtenstion, completion: completion)
   }
}
