//
//  CacheOpreationType.swift
//  WinchCore
//
//  Created by Salah Amassi on 30/12/2020.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation

enum CacheOpreationType {
    case add
    @available(*, deprecated, message: "Use perform function with BalbildSourceCompletion instead")
    case get
    case delete
}
