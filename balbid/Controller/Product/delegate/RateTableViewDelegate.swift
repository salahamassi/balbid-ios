//
//  RateTableViewDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class RateTableViewDelegate: NSObject, UITableViewDelegate {
    
    var shouldShowFooter: Bool = false
    weak var delegate:  EvaluationFooterCellDelegate?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableCell(withIdentifier: .footerRateCellId) as! EvaluationFooterCell
        footerView.delegate = delegate
      
        return  footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return shouldShowFooter ? 60 : 0
    }
    

}
