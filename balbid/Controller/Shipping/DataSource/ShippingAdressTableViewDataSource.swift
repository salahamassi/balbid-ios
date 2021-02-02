//
//  ShippingAdressTableViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 31/01/2021.
//

import UIKit

class ShippingAdressTableViewDataSource: NSObject, UITableViewDataSource {
    
    var selectedIndex = -1
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .shippingAddressCellId, for: indexPath) as! ShippingAddressCell
        cell.isChecked = selectedIndex == indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

}
