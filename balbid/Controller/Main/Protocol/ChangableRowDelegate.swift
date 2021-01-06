//
//  ChangableRowDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import Foundation


protocol ChangableRowDelegate {
    func toggleRows(at section : Int, isExpand: Bool)
}
