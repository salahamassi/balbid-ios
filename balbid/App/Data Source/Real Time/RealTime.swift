//
//  RealTime.swift
//  MSA
//
//  Created by Salah Amassi on 4/23/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

protocol RealTime {

    func add(to path: String, childByAutoId: Bool, params: [String: Any]?, completion: DataSourceCompletion?)

    func update(at path: String, params: [String: Any]?, completion: DataSourceCompletion?)

    func delete(at path: String, completion: DataSourceCompletion?)

    func get(from path: String,
             limit: Int?,
             orderedBy key: String?,
             startingAt value: Any?,
             queryEqual: (toValue: Any, childKey: String)?,
             completion: DataSourceCompletion?)

    func observeChildAdded(at path: String, limit: Int?, completion: DataSourceCompletion?)

    func observeChildUpdated(at path: String, completion: DataSourceCompletion?)

    func observeChildDeleted(at path: String, completion: DataSourceCompletion?)

    func observeValueChanged(at path: String, completion: DataSourceCompletion?)

}
