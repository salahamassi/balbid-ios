//
//  OrderTraceMapViewController.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit

class OrderTraceMapViewController: BaseViewController {

    @IBOutlet weak var shippingInformationView: UIView!
    @IBOutlet weak var mapTransparentView: UIView!
    
    override var mustClearNavigationBar: Bool {
        true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
    }
    
    private func setupNavbar(){
        self.title = "#9254112114455141"
    }

    private func setupView(){
        shippingInformationView.withShadow(color: .black, alpha: 0.7, x: 0, y: 10, blur: 16, spread: 0)
        mapTransparentView.withGradainate(with: [#colorLiteral(red: 0.2549019608, green: 0.431372549, blue: 0.5333333333, alpha: 1),#colorLiteral(red: 0.2196078431, green: 0.5137254902, blue: 0.7725490196, alpha: 1)], locations: [0,1])
    }
}
