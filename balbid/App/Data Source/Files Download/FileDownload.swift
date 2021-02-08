//
//  FileDownload.swift
//  MSA
//
//  Created by Salah Amassi on 5/19/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

protocol FileDownload {

    func download(path: String, name: String?, extention: String?, completion: DataSourceCompletion?)
}
