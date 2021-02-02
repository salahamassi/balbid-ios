//
//  ShippingAddressTableViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ShippingAddressTableViewDelegate: NSObject, UITableViewDelegate {
    
    var didSelect: ((IndexPath) -> ())?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
    }
    
}
