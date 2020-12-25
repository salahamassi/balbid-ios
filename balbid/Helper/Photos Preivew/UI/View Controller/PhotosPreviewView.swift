//
//  PhotosPreviewView.swift
//  MSA
//
//  Created by Salah Amassi on 4/15/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

public class PhotosPreviewView: UIView {

    weak var delegate: PhotosPreviewViewDelegate?

    let blackMaskView = UIView(backgroundColor: .black)
    lazy var collectionView = UICollectionView(scrollDirection: .horizontal, isPagingEnabled: true)
    let topView = UIView(backgroundColor: UIColor(white: 0, alpha: 0.5))
    lazy var backButton = UIButton(image: UIImage(named: "round_arrow_back_ios_black_24pt")?.withRenderingMode(.alwaysTemplate), tintColor: .white, target: self, action: #selector(performBackButtonAction))
    let counterLabel = UILabel(text: "(0/0)", font: UIFont.regular.withSize(15), textColor: #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1), textAlignment: .center, backgroundColor: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9647058824, alpha: 1))
    lazy var deleteButton = UIButton(image: UIImage(named: "ic_delete")?.withRenderingMode(.alwaysTemplate), tintColor: .white, target: self, action: #selector(performRemoveImageButtonAction))

     init() {
        super.init(frame: .zero)
        drawViews()
    }

    required init?(coder: NSCoder) {
        fatalError("Fuck storyboard!")
    }

     func drawViews() {
        backgroundColor = UIColor.black.withAlphaComponent(0)

        topView.addView(hstack(backButton
                    .withSize(.init(width: 24, height: 24)),
                               counterLabel
                                .withSize(.init(width: 48, height: 24))
                                .withCornerRadius(4),
                               deleteButton,
                               alignment: .leading, distribution: .equalCentering)
            .withMargins(.allSides(8)), anchors: .fillSuperView(.zero))

        addView(blackMaskView,
             anchors: .fillSuperView(.zero))

        addView(collectionView
                .withHidden(true),
             anchors: .fillSuperView(.zero))

        addView(topView.withHidden(true),
             anchors:
                .leading(leadingAnchor, constant: 0),
                .top(topAnchor, constant: 0),
                .trailing(trailingAnchor, constant: 0),
                .height(90))

        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleViewPanGestureRecognizer)))
    }

    @objc
    private func performBackButtonAction() {
        delegate?.photosPreviewView(self, performBackButtonAction: backButton)
    }

    @objc
    private func performRemoveImageButtonAction() {
        delegate?.photosPreviewView(self, performRemoveImageButtonAction: backButton)
    }

    @objc
    private func handleViewPanGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        delegate?.photosPreviewView(self, handleViewPanGestureRecognizer: gesture)
    }

}

protocol PhotosPreviewViewDelegate: class {

    func photosPreviewView(_ photosPreviewView: PhotosPreviewView, performBackButtonAction button: UIButton)

    func photosPreviewView(_ photosPreviewView: PhotosPreviewView, performRemoveImageButtonAction button: UIButton)

    func photosPreviewView(_ photosPreviewView: PhotosPreviewView, handleViewPanGestureRecognizer gesture: UIPanGestureRecognizer)

}
