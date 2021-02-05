//
//  CreditBalanceViewController.swift
//  balbid
//
//  Created by Memo Amassi on 03/02/2021.
//

import UIKit

class CreditBalanceViewController: BaseViewController {
    
    @IBOutlet weak var creditBalanceView: UIView!
    @IBOutlet weak var consumedLabel: UILabel!
    @IBOutlet weak var creditBalanceTableView: UITableView!
    
    private let creditBalanceTableViewDataSource = CreditBalanceTableViewDataSource()
    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupConsumedTextLabel()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCreditBalanceView()
    }
    
    
    private func setupNavbar() {
        title = "Credit Balance"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupTableView(){
        creditBalanceTableView.dataSource = creditBalanceTableViewDataSource
    }

    private func setupConsumedTextLabel() {
        let mainText =
            "Been Consumed ".convertToMutableAttributedString(with: UIFont.medium.withSize(14), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  "10.000 SR".convertToAttributedString(with: UIFont.medium.withSize(14), and: #colorLiteral(red: 0.8823529412, green: 0.431372549, blue: 0.03921568627, alpha: 1))
        mainText.append(secondaryText)
        consumedLabel.attributedText = mainText
    }
    
    private func setupCreditBalanceView(){
//        creditBalanceView.backgroundColor = .systemOrange
//        let circularPath = UIBezierPath(arcCenter: creditBalanceView.center, radius: 124, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//        shapeLayer.fillColor = UIColor.red.cgColor
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = UIColor.appColor(.brownColor)?.cgColor
//        shapeLayer.lineWidth = 9
//        shapeLayer.strokeEnd = 4
////        shapeLayer.lineCap = .round
//        self.creditBalanceView.layer.addSublayer(shapeLayer)
//        self.creditBalanceView.layer.borderWidth = 3
        creditBalanceView.withOuterBorder(with: 63, strokeColor: UIColor.appColor(.primaryColor) ?? .white, lineWidth: 9, strokeEnd: 3, clockwise: true)
    }
}
