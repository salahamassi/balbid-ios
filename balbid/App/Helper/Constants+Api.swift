//
//  Constants+Api.swift
//  balbid
//
//  Created by Apple on 16/02/2021.
//

import Foundation

extension String {

    static let domain = "https://tradex.tahwolapps.com/api/"
    static let customerRegisterPath = "customers/store"
    static let loginPath = "customers/login"
    static let logoutPath = "customers/logout"
    static let homePath = "home"
    static let addToFavoritePath = "customers/products/favorite"
    static let removeFromFavoritePath = "customers/products/favorite?product_id="
    static let favoritePath = "customers/products/favorite"
    static let categoryPath = "categories/getLeveling"
    static let categoryProductPath = "products/getInCategory?category_id="
    static let productDetailPath = "products/get?product_id="
    static let productEvaluationPath = "customers/products/evaluation?product_id="

    
    //api Method
    static let post = "post"
    static let get = "get"
    static let delete = "DELETE"
    
}
