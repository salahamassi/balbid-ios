//
//  CategriesCollectionViewFlowLayout.swift
//  balbid
//
//  Created by Qamar Nahed on 31/12/2020.
//

import UIKit

class CategriesContentCollectionViewFlowLayout {
    func setupFlowLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.categoryContentSection()
      }
        return layout
    }
    
    private func categoryContentSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 20
        item.contentInsets.leading = 15
        item.contentInsets.trailing = 15
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 10
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .estimated(48)), elementKind: .topKind, alignment: .topLeading)]
        return section
    }
    

}
