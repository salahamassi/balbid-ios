//
//  HomeCollectionViewFlowLayout.swift
//  balbid
//
//  Created by Qamar Nahed on 26/12/2020.
//

import UIKit

class HomeCollectionViewFlowLayout  {
    var sectionWithFooters: [Int] = []
    func setupFlowLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch (sectionIndex) {
            case 0 :
                return self.sliderSection()
            case 1 :
                return self.sliderIndicatorSection()
            case 2 :
                return self.categorySection()
            //            case 3 :
            //                return self.featureSection()
            //            case 4 :
            //                return self.pickedFeatureSection()
            //            case 5 :
            //                return self.productSection(headerMarginTop: 0, headerMarginBottom: 0)
            //            case 6 :
            //                return self.productSection(headerMarginTop: 30, headerMarginBottom: 16)
            //            case 7 :
            //                return self.adSection(height: 125)
            //            case 8 :
            //                return self.strongestOfferSection()
            //            case 9 :
            //                return self.productSection(headerMarginTop: 0, headerMarginBottom: 0)
            //            case 10 :
            //                return self.adSection(height: 159)
            //            case 11 :
            //                return self.productCategorySection()
            //            case 12 :
            //                return self.productSection(headerMarginTop: 0, headerMarginBottom: 0,shouldShowHeader: false)
            default :
                return self.productSection(headerMarginTop: sectionIndex == 2 ? 16 : 0, headerMarginBottom: 0, shouldShowFooter: self.sectionWithFooters.contains(sectionIndex))
            }
        }
        return layout
    }
    
    private func sliderSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(155))
        let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func sliderIndicatorSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(29))
        let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 12
        return section
    }
    
    private func categorySection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 14
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(85))
        let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 25
        section.contentInsets.leading = 16
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func featureSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 14
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(218),
                                               heightDimension: .estimated(110))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 25
        section.contentInsets.leading = 16
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func pickedFeatureSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 14
        return section
    }
    
    private func productSection(headerMarginTop:CGFloat,headerMarginBottom:CGFloat,shouldShowHeader : Bool = true, shouldShowFooter: Bool = false )-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.leading = 18
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(181),
                                               heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 14
        if  shouldShowHeader {
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .estimated(35 + headerMarginTop+headerMarginBottom)), elementKind: .topKind, alignment: .topLeading)
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(159)), elementKind: UICollectionView.elementKindSectionFooter , alignment: .bottomLeading)
            section.boundarySupplementaryItems = [header]
            if shouldShowFooter {
                section.boundarySupplementaryItems.append(footer)
            }
        }
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func adSection(height :CGFloat)-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 30
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        return section
    }
    
    private func strongestOfferSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 14
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(194))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .estimated(79)), elementKind: .topKind, alignment: .topLeading)]
        return section
    }
    
    private func productCategorySection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 14
        item.contentInsets.trailing = 14
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(151),
                                               heightDimension: .estimated(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        section.contentInsets.top = 14
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
}
