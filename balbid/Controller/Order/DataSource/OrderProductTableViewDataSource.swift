//
//  OrderProductTableViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit

class OrderProductTableViewDataSource: NSObject, UITableViewDataSource {
    
    weak var orderProductCellDelegate: OrderProductCellDelegate?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .orderProductCellId, for: indexPath) as! OrderProductCell
        cell.delegate = orderProductCellDelegate
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    

}
