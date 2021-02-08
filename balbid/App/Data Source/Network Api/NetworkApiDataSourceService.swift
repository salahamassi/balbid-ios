//
//  NetworkApiDataSourceService.swift
//  WinchCore
//
//  Created by Salah Amassi on 20/12/2020.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

public struct NetworkApiDataSourceService: DataSourceService {

    public let path: String
    public let domain: String
    public let method: String
    public let params: [String: Any?]
    public let files: [String: URL]?
    public let mustUseAuth: Bool
    public let mustCaching: Bool
    public let cachePath: String?
    
    public init(path: String, domain: String, method: String, params: [String: Any?], files: [String: URL]? = nil, mustCaching: Bool = false, cachePath: String? = nil, mustUseAuth: Bool = true) {
        self.path = path
        self.domain = domain
        self.method = method
        self.params = params
        self.files = files
        self.mustCaching = mustCaching
        self.cachePath = cachePath
        self.mustUseAuth = mustUseAuth
    }
}
