//
//  SwipeActionDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import Foundation

protocol SwipeActionDelegate: class {
    func deleteItem(at indexPath : IndexPath)
    func addItemToFavorite(at indexPath : IndexPath)

}
