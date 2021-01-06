//
//  CategoriesTableViewDataSource.swift
//  balbid
//
//  Created by Qamar Nahed on 31/12/2020.
//

import UIKit

class CategoriesTableViewDataSource:NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .categoryCellId,for: indexPath)
        return  cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
   
}
