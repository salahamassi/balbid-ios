//
//  File.swift
//  balbid
//
//  Created by Qamar Nahed on 01/01/2021.
//

import Foundation
protocol HomeSelectionProtocol: class {
    func didSelectItem(at indexPath : IndexPath)
    func didMoveHomeSlider(to page : Int)

}
