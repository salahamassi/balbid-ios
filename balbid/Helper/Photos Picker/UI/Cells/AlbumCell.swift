//
//  AlbumCell.swift
//  MSA
//
//  Created by Salah Amassi on 3/24/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

class AlbumCell: BaseTableViewCell<AlbumModel> {
    
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(albumImageView)
        addSubview(albumTitleLabel)
        
        albumImageView.anchor(leading: leadingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 70, height: 70))
        albumImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumTitleLabel.anchor(leading: albumImageView.trailingAnchor,trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 8))
        albumTitleLabel.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor).isActive = true
    }
    
    override func renderItem(item: AlbumModel?) {
        guard let album = item else { return }
        albumTitleLabel.text = album.name + " (\( album.count))"
        albumImageView.image = album.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
