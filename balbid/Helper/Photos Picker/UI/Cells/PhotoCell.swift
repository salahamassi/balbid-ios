//
//  PhotoCell.swift
//  MSA
//
//  Created by Salah Amassi on 2/13/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

class PhotoCell: BaseCollectionViewCell<PhotoWrapper> {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_done")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()

    private var checkImageWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.withCornerRadius(9)
        view.withBorder(1, borderColor: .white)
        return view
    }()

    private let progressView = UIView()
    private let dummyView = UIView()

    let shapeLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(dummyView)
        addSubview(progressView)
        addSubview(checkImageWrapperView)
        checkImageWrapperView.addSubview(checkImageView)

        imageView.fillSuperview()
        dummyView.fillSuperview()
        checkImageWrapperView.anchor(bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 4), size: .init(width: 18, height: 18))
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.centerXAnchor.constraint(equalTo: checkImageWrapperView.centerXAnchor).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: checkImageWrapperView.centerYAnchor).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true

        progressView.translatesAutoresizingMaskIntoConstraints = false

        progressView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 16).isActive = true

        progressView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 8).isActive = true
        progressView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8).isActive = true

        dummyView.backgroundColor = .white

        dummyView.alpha = 0.5

        dummyView.isHidden = true

        let trackLayer = CAShapeLayer()

        let circularPath = UIBezierPath(arcCenter: progressView.center, radius: 8, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 2
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor

        progressView.layer.addSublayer(trackLayer)

        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.3749961853, green: 0.2326006889, blue: 0.5510023236, alpha: 1).cgColor
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat(Double.pi / 2), 0, 0, 1)

        progressView.layer.addSublayer(shapeLayer)
    }

    override func renderItem(item: PhotoWrapper?) {
        guard let photo = item else { return }
        imageView.image = photo.image
        shapeLayer.strokeEnd = CGFloat(photo.progress)

        progressView.isHidden = !photo.isDownloading
        checkImageView.isHidden = !photo.isSelected
        checkImageWrapperView.isHidden = !photo.isSelected

        if photo.isSelected {
            imageView.alpha = 0.7
        } else {
            imageView.alpha = 1
        }
        dummyView.isHidden = !photo.isDownloading
    }

    func updateProgress(_ progress: Double) {
        shapeLayer.strokeEnd = CGFloat(progress)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
