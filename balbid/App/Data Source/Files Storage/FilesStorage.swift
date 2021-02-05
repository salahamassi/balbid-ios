//
//  Firestorage.swift
//  MSA
//
//  Created by Salah Amassi on 4/23/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

protocol FilesStorage {

    func upload(path: String, file: Data, contentType: String?, completion: DataSourceCompletion?)
}
