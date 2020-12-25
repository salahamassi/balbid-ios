//
//  BankInformationViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 23/12/2020.
//

import UIKit

class BankInformationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: ISIntrinsicTableView!
    @IBOutlet weak var addBankButton: UIButton!
    
    let bankInformationTableViewDataSource = BankInfromationTableViewDataSource()
    let bankInfrormationTableViewDelegate = BankInfrormationTableViewDelegate()

    weak var delegate: SizeChangableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView(){
        tableView.delegate = bankInfrormationTableViewDelegate
        tableView.dataSource = bankInformationTableViewDataSource
    }
    
    @IBAction func addOtherBank(_ sender: Any) {
        bankInformationTableViewDataSource.addNewRow()
        delegate?.didUpdateContentSize(newHeight: 247)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.tableView.insertRows(at: [IndexPath(row:(self?.bankInformationTableViewDataSource.rows ?? 1)  - 1, section: 0)], with: .bottom)
        }
    }



}
