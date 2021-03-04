//
//  AuthorizePeopleViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 23/12/2020.
//

import UIKit

class AuthorizePeopleViewController: BaseViewController {

    @IBOutlet weak var tableView: ISIntrinsicTableView!
    @IBOutlet weak var addPersonButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    weak var delegate: SizeChangableDelegate?
    let authorizePeopleTableViewDataSource = AuthorizePeopleTableViewDataSource()
    let authorizePeopleTableViewDelegate = AuthorizePeopleTableViewDelegate()
    private var viewModel = AuthorizedPeopleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = authorizePeopleTableViewDelegate
        tableView.dataSource = authorizePeopleTableViewDataSource
        setupViewModel()
    }

    private func setupViewModel(){
        viewModel.delegate = self
    }
    
    @IBAction func addOtherPerson(_ sender: Any) {
        let row = authorizePeopleTableViewDataSource.rows - 1
        guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AuthPeopleCell else {
            return
        }
        errorLabel.isHidden = true
        let validate = viewModel.validate(name: cell.nameTextField.text!, email: cell.emailTextField.text!, password: cell.passwordTextField.text!, confirmPassword: cell.confirmPasswordTextField.text!, phoneNumber: cell.phoneNumberTextField.text!, job: cell.jobTextField.text!, row: row)
        if(validate) {
            authorizePeopleTableViewDataSource.addNewRow()
            delegate?.didUpdateContentSize(newHeight: 350)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.tableView.insertRows(at: [IndexPath(row: (self?.authorizePeopleTableViewDataSource.rows ?? 1) - 1, section: 0)], with: .bottom)
            }
        }
    }

    
    func validate() -> Bool{
        var isAllVaidate = true
        for i in 0..<authorizePeopleTableViewDataSource.rows {
            guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AuthPeopleCell else {
                return false
            }
            errorLabel.isHidden = true
            let validate = viewModel.validate(name: cell.nameTextField.text!, email: cell.emailTextField.text!, password: cell.passwordTextField.text!, confirmPassword: cell.confirmPasswordTextField.text!, phoneNumber: cell.phoneNumberTextField.text!, job: cell.jobTextField.text!,row: i)
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
        var authorizedPeople: [AuthorizePeople] = []
        for i in 0..<authorizePeopleTableViewDataSource.rows {
            guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AuthPeopleCell else {
                return
            }
            authorizedPeople.append(AuthorizePeople(name: cell.nameTextField.text!, password: cell.passwordTextField.text!, email: cell.emailTextField.text!, phone: cell.phoneNumberTextField.text!))
            
        }
        viewModel.addAll(authorizedPeople: authorizedPeople)
    }
    
}


extension AuthorizePeopleViewController: AuthorizedPeopleViewModelDelegate {
    func validationError(errorMessage: String, withEntry: AuthorizedPeopleViewModel.EntryType, at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? AuthPeopleCell else {
            return
        }
        switch withEntry {
            case .name:
                cell.nameTextField.isError = true
            case .email:
                cell.emailTextField.isError = true
            case .phoneNumber:
                cell.phoneNumberTextField.isError = true
            case .password:
                cell.passwordTextField.isError = true
            case .confirmPassword:
                cell.confirmPasswordTextField.isError = true
            case .job:
                cell.jobTextField.isError = true
        }
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    
}
