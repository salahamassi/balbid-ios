//
//  NetworkApi.swift
//  MSA
//
//  Created by Salah Amassi on 4/23/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

protocol NetworkApi {

    func request(url: String, method: String, params: [String: Any?], files: [String: URL]?, headers: [String: String], completion: DataSourceCompletion?)

}
