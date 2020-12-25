//
//  ThumbnailCell.swift
//  MSA
//
//  Created by Salah Amassi on 2/13/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

class ThumbnailCell: BaseCollectionViewCell<URL>, HasMediaToPreview {

    var mediaView: UIImageView {
        return thumbnailImageView
    }

    public let thumbnailImageView = UIImageView(image: nil, contentMode: .scaleAspectFill, clipsToBounds: true)
    lazy var deleteButton = UIButton(image: UIImage(named: "ic_remove_image")?.withRenderingMode(.alwaysOriginal), target: self, action: #selector(performDeleteButtonAction))

    public var deleteButtonHidden = false {
        didSet {
            deleteButton.isHidden = deleteButtonHidden
        }
    }

    public var image: UIImage? {
        didSet {
            thumbnailImageView.image = image
        }
    }

    public weak var delegate: ThumbnailCellDelegate?

    public override func addViews() {
        super.addViews()
        contentView.addView(thumbnailImageView
            .withCornerRadius(8),
                            anchors:
            .leading(contentView.leadingAnchor, constant: 0),
                            .bottom(contentView.bottomAnchor, constant: 0),
                            .width(45),
                            .height(45))

        contentView.addView(deleteButton,
                            anchors: .top(contentView.topAnchor, constant: 0),
                            .leading(thumbnailImageView.trailingAnchor, constant: -12),
                            .height(24),
                            .width(24))
    }

    public override func renderItem(item: URL?) {
        guard let url = item else { return }
        thumbnailImageView.sd_setImage(with: url, placeholderImage: nil)
    }

    @objc
    private func performDeleteButtonAction() {
        delegate?.thumbnailCell(self, didPress: deleteButton)
    }
}

protocol ThumbnailCellDelegate: class {
    func thumbnailCell(_ thumbnailCell: ThumbnailCell, didPress deleteButton: UIButton)
}
