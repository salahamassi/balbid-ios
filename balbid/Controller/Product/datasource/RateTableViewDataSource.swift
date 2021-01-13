//
//  RateTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class RateTableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .rateCellId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
}
