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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productSizeLabel: UILabel!
    @IBOutlet weak var productColorView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!



    weak var delegate: ProductDetailCollectionViewCellDelegate?
    
    var product: ProductItem? {
        didSet {
            setupProductData(product: product)
        }
    }
    
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
        changeTabIndicatorPosition(value: 0)
        quickReadButton.setTitleColor(UIColor.appColor(.primaryColor), for: .normal)
        rateButton.setTitleColor(UIColor.appColor(.textLightGrayColor), for: .normal)

    }

    @IBAction func viewRate(_ sender: Any) {
        delegate?.productDetailCollectionViewCell(self, performAction: .rate)
        changeTabIndicatorPosition(value: tabIndicatorView.frame.width/2 + 60 + rateButton.frame.width/2 )
        quickReadButton.setTitleColor(UIColor.appColor(.textLightGrayColor), for: .normal)
        rateButton.setTitleColor(UIColor.appColor(.primaryColor), for: .normal)
    }
    
    func changeTabIndicatorPosition(value: CGFloat){
        UIView.animate(withDuration: 0.6) {
            self.tabIndicatorConstraint.constant = value
            self.layoutIfNeeded()
        }
    }
    
    private func setupProductData(product: ProductItem?) {
        guard let product = product  else {
            return
        }
        productNameLabel.text = product.name
        productPriceLabel.text = product.price + " RS"
        pageControl.numberOfPages = product.images.count

    }
        
    enum ActionType {
        case quickLook, rate
    }
}

protocol ProductDetailCollectionViewCellDelegate: class {
    
    func productDetailCollectionViewCell(_ cell: ProductDetailCollectionViewCell, performAction action: ProductDetailCollectionViewCell.ActionType)
}

