//
//  ProductRatingViewController.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit

class ProductRatingViewController: BaseViewController {
    
    @IBOutlet weak var feedbackTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
    }
    
    private func setupNavbar(){
        self.title = "Product Rate"
    }
    
    private func setupView(){
        feedbackTextView.contentInset = UIEdgeInsets.allSides(14)
    }
    
}
