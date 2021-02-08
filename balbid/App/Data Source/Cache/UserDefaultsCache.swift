//
//  UserDefaultsCacheDataSource.swift
//  MSA
//
//  Created by Salah Amassi on 4/23/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

final class UserDefaultsCache: Cache {

    init() {}

    func get(path: String) -> Data? {
        UserDefaults.standard.data(forKey: path)
    }

    func add(path: String, data: Data?) -> Data? {
        UserDefaults.standard.set(data, forKey: path)
        return data
    }

    func delete(path: String) -> Data? {
        let data = UserDefaults.standard.data(forKey: path)
        UserDefaults.standard.set(nil, forKey: path)
        return data
    }
}
