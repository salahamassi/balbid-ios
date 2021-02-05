//
//  OrderDetailViewController.swift
//  balbid
//
//  Created by Memo Amassi on 02/02/2021.
//

import UIKit

class OrderDetailViewController: BaseViewController {
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
    private var orderProductTableViewDataSource = OrderProductTableViewDataSource()
    private var orderProductTableViewDelegate = OrderProductTableViewDelegate()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
        setupTableView()
    }
    
    private func setupNavbar(){
        self.title = "#9254112114455141"
    }
    
    
    private func setupView(){
        let mainText = (cardNumberLabel.text!.components(separatedBy: " ")[0] + " ")
        .convertToMutableAttributedString(with: UIFont.regular.withSize(14), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        let secondaryText =  cardNumberLabel.text!.components(separatedBy: " ")[1].convertToAttributedString(with: UIFont.bold.withSize(30), and: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
        print(cardNumberLabel.text!.components(separatedBy: " ")[1])
        mainText.append(secondaryText)
        cardNumberLabel.attributedText = mainText
    }
    
    
    private func setupTableView(){
        productsTableView.delegate = orderProductTableViewDelegate
        productsTableView.dataSource = orderProductTableViewDataSource
        orderProductTableViewDataSource.orderProductCellDelegate = self
    }
    
    @IBAction func goToReorderController(_ sender: Any){
        router?.navigate(to: .reorderRoute)
    }


}

extension OrderDetailViewController: OrderProductCellDelegate{
    func orderProductCell(_ orderProductCell: OrderProductCell) {
        router?.navigate(to: .productTraceRoute)
    }
}
