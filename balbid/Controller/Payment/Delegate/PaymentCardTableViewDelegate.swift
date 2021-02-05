//
//  PaymentCardTableViewDelegate.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class PaymentCardTableViewDelegate: NSObject, UITableViewDelegate {
    
    var didSelectRow: ((IndexPath) -> ())?

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(indexPath)
    }

}
