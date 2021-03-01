//
//  FavoriteTableViewDataSource.swift
//  balbid
//
//  Created by Memo Amassi on 24/01/2021.
//

import UIKit

class FavoriteTableViewDataSource: NSObject, UITableViewDataSource {
    
    var favorite: Product?
    weak var delegate: FavoriteCellDelegate?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .favoriteCellId, for: indexPath) as! FavoriteCell
        cell.favorite = favorite?.productItems[indexPath.row]
        cell.delegate = delegate
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorite?.productItems.count ?? 0
    }

}
