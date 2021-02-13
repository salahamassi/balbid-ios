//
//  CartCellDelegate.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit

protocol ProductCellDelegate: class {
    func productCollectionViewCell(productCollectionViewCell: ProductCollectionViewCell, perform action: ProductCollectionViewCell.ActionType, with product: Product?)
}
