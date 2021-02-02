//
//  OrderProductCell.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit

class OrderProductCell: UITableViewCell {
    
    weak var delegate: OrderProductCellDelegate?

    @IBAction func showOrderProductDetail(_ sender: Any){
        delegate?.orderProductCell(self)
    }
    
   
}

protocol OrderProductCellDelegate: class {
    func orderProductCell(_ orderProductCell: OrderProductCell )
}
