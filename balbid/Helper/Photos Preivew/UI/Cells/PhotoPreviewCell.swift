//
//  PhotoPreviewCell.swift
//  MSA
//
//  Created by Salah Nahed on 3/11/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

class PhotoPreviewCell: BaseCollectionViewCell<MediaWrapper> {
    
    let photoImageView = UIImageView(contentMode: .scaleAspectFit)
    
    override func addViews() {
        super.addViews()
        contentView.addView(scroll(photoImageView)
            .withDelegate(self)
            .withZoomScale(minimumZoomScale: 1.0, maximumZoomScale: 10.0)
            .shouldShowsVerticalScrollIndicator(false)
            .shouldShowsHorizontalScrollIndicator(false),
                            anchors: .fillSuperView(.zero))
        photoImageView.constrainHeight(frame.height)
    }
    
    override func renderItem(item: MediaWrapper?) {
        guard let item = item else { return }
        photoImageView.sd_setImage(with: item.url, completed: nil)
    }
}

extension PhotoPreviewCell: UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
