//
//  AlbumViewController.swift
//  MSA
//
//  Created by Salah Amassi on 3/24/20.
//  Copyright © 2020 winch. All rights reserved.
//

import UIKit
import Photos

class AlbumViewController: UITableViewController {

    var data = [AlbumModel]()

    weak var delegate: AlbumViewControllerDelegate?
    private let albumCellId = "albumCellId"

    @available(iOS 12.0, *)
    var isDarkMode: Bool {
        UserDefaultsManager.isDarkMode || traitCollection.userInterfaceStyle == .dark
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    fileprivate func setupViewController() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        view.backgroundColor = UIColor.appColor(.viewBackgroundColor)
        clearsSelectionOnViewWillAppear = false
        tableView.register(AlbumCell.self, forCellReuseIdentifier: albumCellId)
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.separatorColor = UIColor.appColor(.labelColor)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: albumCellId, for: indexPath) as! AlbumCell
        cell.item = data[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.albumViewController(albumViewController: self, didSelect: data[indexPath.row])
    }

    // Setup the ViewController for popover presentation
    func updatePopOverViewController(_ button: UIButton?, with delegate: PhotosCollectionViewController?) {
        guard let button = button else { return }
        modalPresentationStyle = .popover
        popoverPresentationController?.permittedArrowDirections = [.any]
        popoverPresentationController?.backgroundColor = UIColor.appColor(.viewBackgroundColor)
        popoverPresentationController?.sourceView = button
        popoverPresentationController?.sourceRect = button.bounds
        popoverPresentationController?.delegate = delegate
    }
}

protocol AlbumViewControllerDelegate: class {
    func albumViewController(albumViewController: AlbumViewController, didSelect album: AlbumModel)
}
