//
//  BaseTableViewCell.swift
//  MSA
//
//  Created by Salah Amassi on 10/20/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

class BaseTableViewCell<E>: UITableViewCell {

     var item: E? {
        didSet {
            renderItem(item: item)
        }
    }

    open func renderItem(item: E?) {
        preconditionFailure("This method must be overridden")
    }

}
