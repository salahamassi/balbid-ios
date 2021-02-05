//
//  CreditBalanceTableViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 05/02/2021.
//

import UIKit

class CreditBalanceTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .creditBalanceCellId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

}
