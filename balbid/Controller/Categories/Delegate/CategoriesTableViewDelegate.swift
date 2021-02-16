//
//  categoriesTableViewDelegate.swift
//  balbid
//
//  Created by Apple on 16/02/2021.
//

import UIKit

class CategoriesTableViewDelegate: NSObject, UITableViewDelegate {
    
    var didSelect: ((IndexPath) -> Void)?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
    }
}
