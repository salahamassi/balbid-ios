//
//  PhotosPreviewRoute.swift
//  MSA
//
//  Created by Salah Amassi on 5/15/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

struct PhotosPreviewRoute: Route {

    private let animator = PhotosPreviewViewControllerPresentDismissAnimator()

    var modalPresentationStyle: UIModalPresentationStyle {
        return .custom
    }
    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        return animator
    }

    var navigateType: NavigateType {
        return .present
    }

    init() {}

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        guard let medias = params?["medias"] as? [MediaWrapper] else { fatalError("cann't start photosPreviewViewController without medias")}
        guard let currentIndex = params?["currentIndex"] as? Int else { fatalError("cann't start photosPreviewViewController without currentIndex")}
        guard let mustHideDeleteButton = params?["mustHideDeleteButton"] as? Bool else { fatalError("cann't start photosPreviewViewController without mustHideDeleteButton")}
        guard let mediaContainerView = params?["mediaContainerView"] as? HasMediaToPreview else { fatalError("cann't start photosPreviewViewController without mediaContainerView")}
        let delegate = params?["delegate"] as? PhotosPreviewViewControllerDelegate
        let photosPreviewViewController = PhotosPreviewViewController(router: router, medias: medias, currentIndex: currentIndex, mustHideDeleteButton: mustHideDeleteButton, delegate: delegate)
        animator.mediaContainerView = mediaContainerView
        return photosPreviewViewController
    }
}
