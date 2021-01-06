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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (isExpanded[section] ?? false) ? 5 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .categoryContentCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: .topKind, withReuseIdentifier: .categoryContentHeaderCellId, for: indexPath) as! CategoryContentHeaderCollectionViewCell
        header.tag = indexPath.section
        header.isExpanded = isExpanded[indexPath.section] ?? false
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleSection)))
        return header
    }
    
    @objc func toggleSection(_ sender : UITapGestureRecognizer){
        guard let senderView = sender.view as? CategoryContentHeaderCollectionViewCell else {
            return
        }
        let section = senderView.tag
        if(isExpanded[section] ==  nil || !(isExpanded[section] ?? false)){
            isExpanded[section] = true
        }else{
            isExpanded[section] = false
        }
        senderView.isExpanded = isExpanded[section] ?? false
        delegate?.toggleRows(at: section, isExpand: isExpanded[section] ?? false)
    }
    
}
