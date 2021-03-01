//
//  Extension+NSNotification.swift
//  balbid
//
//  Created by Apple on 01/03/2021.
//

import Foundation

extension  NSNotification.Name {
    static let didAddToFavorite = Notification.Name("didAddToFavorite")
    static let didRemoveFromFavorite = Notification.Name("didRemoveFromFavorite")
}
