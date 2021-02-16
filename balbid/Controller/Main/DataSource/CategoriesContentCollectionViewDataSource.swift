//
//  CategoriesContentTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 31/12/2020.
//

import UIKit

class CategoriesContentCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var isExpanded : Dictionary<Int,Bool> = [:]
    var delegate: ChangableRowDelegate?
    var categoriesItem: [CategoryItem] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categoriesItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (isExpanded[section] ?? false) ? categoriesItem[section].children.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .categoryContentCellId, for: indexPath)  as! CategoryContentCell
        cell.categoryItem = categoriesItem[indexPath.section].children[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: .topKind, withReuseIdentifier: .categoryContentHeaderCellId, for: indexPath) as! CategoryContentHeaderCollectionViewCell
        header.tag = indexPath.section
        header.isExpanded = isExpanded[indexPath.section] ?? false
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleSection)))
        header.categoryItem =  categoriesItem[indexPath.section]
        return header
    }

    
    @objc func toggleSection(_ sender : UITapGestureRecognizer){
        guard let senderView = sender.view as? CategoryContentHeaderCollectionViewCell,
              let collectionView = senderView.superview as? UICollectionView,
              let indexPath = collectionView.indexPathForSupplementaryElement(senderView, ofKind: .topKind)
              else {
            return
        }
        if(isExpanded[indexPath.section] ==  nil || !(isExpanded[indexPath.section] ?? false)){
            isExpanded[indexPath.section] = true
        }else{
            isExpanded[indexPath.section] = false
        }
        senderView.isExpanded = isExpanded[indexPath.section] ?? false
        delegate?.toggleRows(at: indexPath.section, isExpand: (isExpanded[indexPath.section] ?? false))
    }
    
}
