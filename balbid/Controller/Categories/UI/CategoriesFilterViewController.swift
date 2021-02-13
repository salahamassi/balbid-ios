//
//  CategoriesFilterViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit

class CategoriesFilterViewController: BaseViewController {
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var colorValueLabel: UILabel!
    @IBOutlet var colorSpaceView: [UIView]!
    
    @IBOutlet weak var priceViewLabel: UILabel!
    @IBOutlet var priceSpaceView: [UIView]!

    

    @IBOutlet weak var bottomView: UIView!
    
    let colorCollectionViewDelegate = ColorCollectionViewDelegate()
    let colorCollectionViewDataSource = ColorCollectionViewDataSource()
    let priceSeekBarView = PriceSeekBarView.initFromNib()
    
    override var mustClearNavigationBar: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        setupCollectionView()
        setupPriceView()
    }
    
    private func setupView(){
        bottomView.withShadow(color: #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 1), alpha: 0.05, x: 0, y: -1, blur: 20, spread: 0)
    }

    private func setupCollectionView(){
        colorCollectionView.delegate = colorCollectionViewDelegate
        colorCollectionView.dataSource = colorCollectionViewDataSource
    }
    
    private func setupNavBar(){
        (navigationController as! AppNavigationController).restyleBackButton()
        title = "Filter"
        let rightNavButton = UIBarButtonItem(image: UIImage(named: .closeImage), style: .plain, target: self, action: #selector(self.back))
        navigationItem.rightBarButtonItem = rightNavButton
    }
    
    @IBAction func showColorCollectionView(_ sender: Any) {
        colorValueLabel.animateIsHidden(value: colorCollectionView.isHidden)
        colorSpaceView[0].animateIsHidden(value: colorCollectionView.isHidden)
        colorCollectionView.animateIsHidden(value: !colorCollectionView.isHidden)
    }
    
    private func setupPriceView(){
        priceView.addSubview(priceSeekBarView)
    }
    
    @objc func back(){
        router?.pop(numberOfScreens: 1)
    }

}
