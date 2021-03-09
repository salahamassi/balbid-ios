//
//  SliderContainerCell.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SliderContainerCell: UICollectionViewCell {
    
    @IBOutlet weak var  collectionView: UICollectionView!
    weak var delegate: HomeSelectionProtocol? {
        didSet {
            sliderImageDelegate.delegate = delegate
        }
    }

    var images: [SliderImage] = [] {
        didSet {
            sliderImageDataSource.images = images
        }
    }
    
    private let sliderImageDataSource = SliderImageDataSource()
    private let sliderImageDelegate = SliderImageDelegate()
    
    override func awakeFromNib() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = sliderImageDataSource
        collectionView.delegate = sliderImageDelegate
        sliderImageDelegate.collectionView = collectionView
        
    }
}
