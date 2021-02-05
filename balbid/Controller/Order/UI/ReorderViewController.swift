//
//  ReorderViewController.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class ReorderViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var reorderCollectionViewDataSource = ReorderCollectionViewDataSource()
    private var reorderCollectionViewDelegate = ReorderCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
    }

    private func setupNavbar(){
        self.title = "Reorder"
    }
    
    private func setupView(){
        collectionView.dataSource = reorderCollectionViewDataSource
        collectionView.delegate = reorderCollectionViewDelegate
        reorderCollectionViewDelegate.didSelectRow = { indexPath in
            if self.reorderCollectionViewDataSource.checkedIndexPath.contains(indexPath) {
                guard let index = self.reorderCollectionViewDataSource.checkedIndexPath.firstIndex(of: indexPath) else {
                    return
                }
                self.reorderCollectionViewDataSource.checkedIndexPath.remove(at: index)
            }else{
                self.reorderCollectionViewDataSource.checkedIndexPath.append(indexPath)
            }
            self.collectionView.reloadItems(at: [indexPath])
        }
    }

    
    @IBAction func selectAllAction(_ sender: Any){
        self.reorderCollectionViewDataSource.checkedIndexPath.removeAll()
        for i in 0 ..< 10 {
            self.reorderCollectionViewDataSource.checkedIndexPath.append(IndexPath(row: i, section: 0))
        }
        self.collectionView.reloadData()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        router?.navigate(to: .addedToCartRoute)
    }
    
}
