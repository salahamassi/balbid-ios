//
//  Cache.swift
//  MSA
//
//  Created by Salah Amassi on 4/23/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

protocol Cache {

    func get(path: String) -> Data?

    func add(path: String, data: Data?) -> Data?

    func delete(path: String) -> Data?

}
