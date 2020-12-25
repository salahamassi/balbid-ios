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

    weak var delegate: SizeChangableDelegate?
    let authorizePeopleTableViewDataSource = AuthorizePeopleTableViewDataSource()
    let authorizePeopleTableViewDelegate = AuthorizePeopleTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = authorizePeopleTableViewDelegate
        tableView.dataSource = authorizePeopleTableViewDataSource
    }

    @IBAction func addOtherPerson(_ sender: Any) {
        authorizePeopleTableViewDataSource.addNewRow()
        delegate?.didUpdateContentSize(newHeight: 190)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.tableView.insertRows(at: [IndexPath(row: (self?.authorizePeopleTableViewDataSource.rows ?? 1) - 1, section: 0)], with: .bottom)
        }
    }

}
