//
//  AuthorizePeopleDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 23/12/2020.
//

import UIKit

class AuthorizePeopleTableViewDataSource: NSObject, UITableViewDataSource {

    var rows = 1
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .authorizePeopleCellId, for: indexPath) as!  AuthPeopleCell
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows
    }

    func addNewRow() {
        rows += 1
    }

}
