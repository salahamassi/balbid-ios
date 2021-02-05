//
//  DataSourceService.swift
//  MSA
//
//  Created by Salah Amassi on 20/12/2020.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

protocol DataSourceService {

    var path: String { get }

}
// MARK: - helper extension
extension Dictionary {

    func toData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
