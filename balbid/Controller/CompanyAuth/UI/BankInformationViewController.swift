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
    @IBOutlet weak var errorLabel: UILabel!

    private let bankInformationTableViewDataSource = BankInfromationTableViewDataSource()
    private let bankInfrormationTableViewDelegate = BankInfrormationTableViewDelegate()
    private let viewModel = BankInformationViewModel()

    weak var delegate: SizeChangableDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()

        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
    }
    private func setupTableView() {
        tableView.delegate = bankInfrormationTableViewDelegate
        tableView.dataSource = bankInformationTableViewDataSource
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }

    @IBAction func addOtherBank(_ sender: Any) {
        let row = bankInformationTableViewDataSource.rows - 1
        guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? BankInformationCell else {
            return
        }
    
        let validate = viewModel.validate(mainBank: cell.bankNameTextField.text!, cityName: cell.cityTextField.text!, holderName: cell.holderNameTextField.text!, iban: cell.ibanTextField.text!, row: row)
        if(validate) {
            errorLabel.isHidden = true
            bankInformationTableViewDataSource.addNewRow()
            delegate?.didUpdateContentSize(newHeight: 247)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.tableView.insertRows(at: [IndexPath(row: (self?.bankInformationTableViewDataSource.rows ?? 1)  - 1, section: 0)], with: .bottom)
            }
        }
    }

    
    private func setData() {
        #if DEBUG
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BankInformationCell else {
            return
        }
        cell.bankNameTextField.text = "Salah Amassi"
        cell.holderNameTextField.text = "12345"
        cell.ibanTextField.text = "12345"
        cell.cityTextField.text = "21212"
        #endif
    }
    
    func validate() -> Bool{
        var isAllVaidate = true
        for i in 0..<bankInformationTableViewDataSource.rows {
            guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? BankInformationCell else {
                return false
            }
            errorLabel.isHidden = true
            let validate = viewModel.validate(mainBank: cell.bankNameTextField.text!, cityName: cell.cityTextField.text!, holderName: cell.holderNameTextField.text!, iban: cell.ibanTextField.text!, row: i)
            if !validate  {
                isAllVaidate = false
            }
        }
        if isAllVaidate {
            addAll()
        }
        return isAllVaidate
    }
    
    func addAll() {
        var banksInformation: [BankInformation] = []
        for i in 0..<bankInformationTableViewDataSource.rows {
            guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? BankInformationCell else {
                return
            }
            banksInformation.append(BankInformation(mainBank: cell.bankNameTextField.text!, cityName: cell.cityTextField.text!, holderName: cell.holderNameTextField.text!, iban: cell.ibanTextField.text!))
            
        }
        viewModel.addAll(banksInformation: banksInformation)
    }
    
}


extension BankInformationViewController: BankInformationViewModelDelegate {
    func validationError(errorMessage: String, withEntry:  BankInformationViewModel.EntryType, at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? BankInformationCell else {
            return
        }
        switch withEntry {
        case .mainBank:
                cell.bankNameTextField.isError = true
        case .cityName:
                cell.cityTextField.isError = true
        case .holderName:
                cell.holderNameTextField.isError = true
        case .iban:
                cell.ibanTextField.isError = true
          
        }
        
        errorLabel.isHidden = false
        errorLabel.text = errorMessage

    }
    
    
}
