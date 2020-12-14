//
//  PhotoWrapper.swift
//  MSA
//
//  Created by Salah Amassi on 2/13/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import Foundation
import UIKit

struct PhotoWrapper {
    let image: UIImage
    var isDownloading: Bool
    var progress: Double
    var isSelected: Bool
    var mustDownloadImage: Bool = true
}
