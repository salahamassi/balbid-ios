//
//  PhotosCollectionViewControllerRouteRoute.swift
//  MSA
//
//  Created by Salah Amassi on 5/15/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit
import AppRouter

struct PhotosPickerRoute: Route {

    var navigateType: NavigateType {
        .present
    }

    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController {
        let delegate = params?["delegate"] as? PhotosCollectionViewControllerDelegate
        let maxSelection = params?["maxSelection"] as? Int
        let rootViewController = PhotosCollectionViewController(delegate: delegate)
        rootViewController.maxSelection = maxSelection
        let photosCollectionViewController = UINavigationController(rootViewController: rootViewController)
        return photosCollectionViewController
    }
}
