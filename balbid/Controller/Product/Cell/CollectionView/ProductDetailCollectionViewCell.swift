//
//  ProductDetailCollectionViewCell.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quickReadButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var tabIndicatorConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabIndicatorView: UIView!

    
    weak var delegate: ProductDetailCollectionViewCellDelegate?
    
    lazy var productDetailQuickViewViewController : ProductDetailQuickViewViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailQuickViewViewController) as! ProductDetailQuickViewViewController
        return viewController
    }()
    
    lazy var productDetailRateViewController : ProductDetailRateViewController = {
        let viewController = UIStoryboard.productStoryboard.getViewController(with: .productDetailRateViewController) as! ProductDetailRateViewController
        return viewController
    }()
  
    @IBAction func viewQuickLook(_ sender: Any) {
        delegate?.productDetailCollectionViewCell(self, performAction: .quickLook)
    }

    @IBAction func viewRate(_ sender: Any) {
        delegate?.productDetailCollectionViewCell(self, performAction: .rate)
    }
        
    enum ActionType {
        case quickLook, rate
    }
}

protocol ProductDetailCollectionViewCellDelegate: class {
    
    func productDetailCollectionViewCell(_ cell: ProductDetailCollectionViewCell, performAction action: ProductDetailCollectionViewCell.ActionType)
}

