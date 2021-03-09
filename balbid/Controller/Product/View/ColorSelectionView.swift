//
//  ColorSelectionView.swift
//  balbid
//
//  Created by Apple on 03/03/2021.
//

import UIKit

class ColorSelectionView: BottomSheetView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var colorSelectionDataSource = ColorSelectionDataSource()
    private var colorSelectionDelegate = ColorSelectionDelegate()
    var optionGroupItem:  OptionGroupItem?
    var didSelectOption: ((_ id: Int) -> Void)?
    
    override class func initFromNib() -> ColorSelectionView {
        return Bundle.init(for: ColorSelectionView.self).loadNibNamed(.colorSelectionView, owner: self, options: nil)!.first as! ColorSelectionView
    }
    
    override func awakeFromNib() {
        viewHeight = 180
        super.awakeFromNib()
    }
    
    internal override func setupSheetView() {
        super.setupSheetView()
        setupCollection()

    }
    
    private func setupCollection() {
        registerCell()
        collectionView.dataSource = colorSelectionDataSource
        colorSelectionDataSource.optionItems = optionGroupItem?.options ?? []
        collectionView.delegate = colorSelectionDelegate
        colorSelectionDelegate.didSelectRow = { [weak self] index in
            self?.colorSelectionDataSource.selectedIndex = index
            self?.collectionView.reloadData()
        }
    }
    
    @IBAction func selectColor(_ sender: Any) {
        didSelectOption?(colorSelectionDataSource.selectedIndex)
        hide()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: .colorSelectionCell, bundle: nil), forCellWithReuseIdentifier: .colorCellId)
    }
    
}
