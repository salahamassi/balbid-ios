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
    var didSelectOption: ((_ id: Int) -> Void)?


    var optionGroupItem:  OptionGroupItem?
    
    override class func initFromNib() -> SizeSelectionView {
        return Bundle.init(for: SizeSelectionView.self).loadNibNamed(.sizeSelectionView, owner: self, options: nil)!.first as! SizeSelectionView
    }
    
    override func awakeFromNib() {
        viewHeight = 180
        super.awakeFromNib()
    }
    
    internal override func setupSheetView() {
        super.setupSheetView()
        setupCollection()

    }
    
    @IBAction func selectSize(_ sender: Any) {
        didSelectOption?(sizeSelectionDataSource.selectedIndex)
        hide()
    }
    
    private func setupCollection() {
        registerCell()
        sizeSelectionDataSource.optionItems = optionGroupItem?.options ?? []
        collectionView.dataSource = sizeSelectionDataSource
        collectionView.delegate = sizeSelectionDelegate
        sizeSelectionDelegate.didSelectRow = { [weak self] index in
            self?.sizeSelectionDataSource.selectedIndex = index
            self?.collectionView.reloadData()
        }
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: .sizeSelectionCell, bundle: nil), forCellWithReuseIdentifier: .sizeCellId)
    }
    
}
