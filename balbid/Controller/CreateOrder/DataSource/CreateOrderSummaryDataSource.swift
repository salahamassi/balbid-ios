//
//  CreateOrderSummaryDataSource.swift
//  balbid
//
//  Created by Apple on 13/03/2021.
//

import UIKit

class CreateOrderSummaryDataSource: NSObject, UITableViewDataSource {
    
    var cart: Cart?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart?.cartItem.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .orderProductCellId, for: indexPath) as! OrderProductSummeryCell
        cell.configure(cartItem: cart!.cartItem[indexPath.row], count: cart!.cartItem.count, index: indexPath.row)
        return cell
    }
}
