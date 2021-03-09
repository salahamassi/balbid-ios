//
//  SliderImageDataSource.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SliderImageDataSource: NSObject, UICollectionViewDataSource {
    
    var images: [SliderImage] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .imageSliderCellId, for: indexPath) as! ImageSliderCell
        cell.sliderImage = images[indexPath.row].image
        return cell
    }
    

}
