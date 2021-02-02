//
//  OrderTableViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class OrderTableViewDelegate: NSObject, UITableViewDelegate {
    
    var didSelectRow: ((IndexPath) -> ())?
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: .orderHeaderCellId)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(indexPath)
    }
}
