//
//  SizeSelectionView.swift
//  balbid
//
//  Created by Apple on 09/03/2021.
//

import UIKit

class SizeSelectionView: BottomSheetView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var sizeSelectionDataSource = SizeSelectionDataSource()
    private var sizeSelectionDelegate = SizeSelectionDelegate()
    
    var optionGroupItem:  OptionGroupItem?
    
    override class func initFromNib() -> SizeSelectionView {
        return Bundle.init(for: SizeSelectionView.self).loadNibNamed(.sizeSelectionView, owner: self, options: nil)!.first as! SizeSelectionView
    }
    
    override func awakeFromNib() {
        viewHeight = 128
        super.awakeFromNib()
    }
    
    internal override func setupSheetView() {
        super.setupSheetView()
        setupCollection()

    }
    
    private func setupCollection() {
        registerCell()
        sizeSelectionDataSource.optionItems = optionGroupItem?.options ?? []
        collectionView.dataSource = sizeSelectionDataSource
        sizeSelectionDelegate.optionItems = optionGroupItem?.options ?? []
        
        collectionView.delegate = sizeSelectionDelegate
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: .sizeSelectionCell, bundle: nil), forCellWithReuseIdentifier: .sizeCellId)
    }
    
}
