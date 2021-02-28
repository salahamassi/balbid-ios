//
//  RateTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class RateTableViewDataSource: NSObject, UITableViewDataSource {
    
    var evaluation: EvaluationItem?

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .rateCellId, for: indexPath) as!  EvaluationCell
        cell.comment = evaluation?.comments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        evaluation?.comments.count ?? 0
    }
    
    
}
