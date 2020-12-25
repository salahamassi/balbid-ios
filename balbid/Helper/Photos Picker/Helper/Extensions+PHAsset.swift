//
//  Extensions+PHAsset.swift
//  MSA
//
//  Created by Salah Amassi on 26/11/2020.
//  Copyright © 2020 MSA. All rights reserved.
//

import Photos
import UIKit

extension PHAsset {

    func getURL( progressHandler : @escaping (_ progress: Double, _ error: Error?) -> Void, completionHandler : @escaping ((_ responseURL: URL?, _ image: UIImage?) -> Void)) {
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(_: PHAdjustmentData) -> Bool in
                return true
            }

            let otherOptions = PHImageRequestOptions()
            otherOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            otherOptions.isSynchronous = false
            otherOptions.isNetworkAccessAllowed = true

            otherOptions.progressHandler = {  (progress, error, _, _) in
                DispatchQueue.main.async {
                    progressHandler(progress, error)
                    //      print("progress: \(progress)")
                }
            }

            PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: otherOptions, resultHandler: {
                (image, info) in
                DispatchQueue.main.async {
                    completionHandler(info?["PHImageFileURLKey"] as? URL, image)
                }

            })

        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.isNetworkAccessAllowed = true
            options.version = .original

            options.progressHandler = {  (progress, error, _, _) in
                DispatchQueue.main.async {
                    progressHandler(progress, error)
                    //  print("progress: \(progress)")
                }            }
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, _: AVAudioMix?, _: [AnyHashable: Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    DispatchQueue.main.async {
                        completionHandler(localVideoUrl, nil)
                    }
                } else {
                    completionHandler(nil, nil)
                }
            })
        }
    }
}
