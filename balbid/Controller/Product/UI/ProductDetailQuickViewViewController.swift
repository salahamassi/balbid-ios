//
//  ProductDetailQuickViewViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 06/01/2021.
//

import UIKit

class ProductDetailQuickViewViewController: BaseViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    var product: ProductItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData(product: product)
        
    }
    
    
    private func setupLabel(){
        let numOfLine = detailLabel.text!.calculateNumberLine(for: view.frame.width, with: UIFont.regular.withSize(14))
        readMoreButton.isHidden = numOfLine <= 2
    }

    @IBAction func expandLabel(_ sender: Any){
        UIView.animateKeyframes(withDuration: 0.6, delay: 0) {
            self.detailLabel.numberOfLines =  self.detailLabel.numberOfLines != 0 ? 0 : 2
        } completion: { (_) in
            self.readMoreButton.isHidden =  self.detailLabel.numberOfLines == 0 
        }

    }
    
    private func setData(product: ProductItem?){
        guard let product = product,
              let label = detailLabel else {
            return
        }
        label.attributedText = product.description.htmlToAttributedString 
        setupLabel()        
    }
    
 
    

}
