//
//  HomeCollectionViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 27/12/2020.
//

import UIKit

class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var numberOfSection = 0
    var home: Home?
    var currentPage: Int = 0
    weak var delegate: SliderIndicatorCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .sliderCellId, for: indexPath) as! HomeSliderCell
            cell.sliderImage = home?.imageSlider[indexPath.row]
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .sliderIndicatorCellId, for: indexPath) as! SliderIndicatorCollectionViewCell
            cell.pageControl.numberOfPages = home?.imageSlider.count ?? 0
            cell.currentPage = currentPage
            cell.delegate = delegate
            return cell
        }
        //        else if indexPath.section == 2 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .categoryCellId, for: indexPath)
        //            return cell
        //        }else if indexPath.section == 3{
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .offerCellId, for: indexPath)
        //            return cell
        //        }else if indexPath.section == 4{
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .pickedFeatureCellId, for: indexPath)
        //            return cell
        //        }else if indexPath.section == 7 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .addCellId, for: indexPath)
        //            return cell
        //        }else if indexPath.section == 8 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .strongestOfferCellId, for: indexPath)
        //            return cell
        //        }else if indexPath.section == 10 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .offerAdCellId, for: indexPath)
        //            return cell
        //        }else if indexPath.section == 11 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productCategoryCellId, for: indexPath)
        //            return cell
        //        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .productCellId, for: indexPath) as! ProductCollectionViewCell
            cell.product = home?.HomeProductItems[indexPath.section - 2].prodcuts[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return home?.imageSlider.count ?? 0
        }else if section == 1 {
            return 1
        }
        //        else if section == 3 {
        //            return 2
        //        }else if section == 4 {
        //            return 2
        //        }else if section == 5 {
        //            return 7
        //        }else if section == 7 {
        //            return 1
        //        }else if section == 8 {
        //            return 4
        //        }else if section == 10 {
        //            return 1
        //        }
        return home?.HomeProductItems[section - 2].prodcuts.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if  indexPath.section ==  6 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: .topKind, withReuseIdentifier: .wholesaleOffersHeaderCellId, for: indexPath)
            return header
        }else if indexPath.section == 8 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: .topKind, withReuseIdentifier: .strongestOfferProductHeaderCellId, for: indexPath)
            return header
        }else if kind == UICollectionView.elementKindSectionFooter  {
            
            if let banner = home?.banners.first(where: { (banner) -> Bool in
                banner.sortOrder == "\(indexPath.section - 1)"
            }) {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter , withReuseIdentifier: .productFooterCellId, for: indexPath) as! ProductFooterCell
                footer.banner = banner
                return footer
            }
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: .topKind, withReuseIdentifier: .productHeaderCellId, for: indexPath) as! ProductHeaderCell
        header.homeProductItem = home?.HomeProductItems[indexPath.section - 2]
        return header
        
    }
}
