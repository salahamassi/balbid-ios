//
//  Extensions+UITableView.swift
//  MSA
//
//  Created by Salah Amassi on 10/20/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit

extension UITableView{
    
    convenience init (style: UITableView.Style = UITableView.Style.plain ,spreatorStyle: UITableViewCell.SeparatorStyle = UITableViewCell.SeparatorStyle.singleLine, keyboardDismissMode: UIScrollView.KeyboardDismissMode = .none){
        self.init(frame: .zero ,style: style)
        self.separatorStyle = spreatorStyle
        self.keyboardDismissMode = keyboardDismissMode
        self.backgroundColor = .clear
    }
    
    @discardableResult
    func register(cells: (cellClass: UITableViewCell.Type, cellId: String) ...) -> UITableView{
        for cell in cells{
            register(cell.cellClass, forCellReuseIdentifier: cell.cellId)
        }
        return self
    }
    
    func register(cells: (nibName: String, cellId: String) ...){
        cells.forEach {
            register(UINib(nibName: $0.nibName, bundle: nil), forCellReuseIdentifier: $0.cellId)
        }
    }
    
    @discardableResult
    func withContentInset(_ contentInset: UIEdgeInsets) -> UITableView{
        self.contentInset = contentInset
        return self
    }
    
    func scrollToBottom(animated: Bool) {
        let numberOfSections = self.numberOfSections
        if numberOfSections > 0{
            let numberOfRows = self.numberOfRows(inSection: numberOfSections - 1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: (numberOfSections - 1))
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
}
