//
//  PaymentCardTableViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class PaymentCardTableViewDataSource: NSObject, UITableViewDataSource {
    
    var selectedIndex = -1
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .paymentCardCellId, for: indexPath) as! PaymentCardCell
        cell.isChecked = indexPath.row == selectedIndex
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

}
