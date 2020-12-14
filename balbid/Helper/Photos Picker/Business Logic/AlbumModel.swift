//
//  AlbumModel.swift
//  MSA
//
//  Created by Salah Amassi on 3/24/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import Photos
import UIKit

struct AlbumModel {
    let name: String
    let count: Int
    let collection: PHAssetCollection
    var image: UIImage? = nil
}
