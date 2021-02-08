//
//  AlamofireFileDownload.swift
//  MSA
//
//  Created by Salah Amassi on 5/19/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireFileDownload: FileDownload {

    init() {}

    func download(path: String, name: String?, extention: String?, completion: DataSourceCompletion?) {
        guard let url = URL(string: path) else { return }

        let destination: DownloadRequest.Destination = { temporaryURL, _ in
            _ = URL.createFolder(folderName: "winch")!
            let fileName: String
            if let pathExtension = extention {
                fileName = "winch" + "/" + (name ?? (UUID.init().uuidString))  + "." + pathExtension
            } else {
                fileName =  "winch" + "/" + (name ?? (UUID.init().uuidString))  + "." + temporaryURL.pathExtension
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                completion?(fileName.data(using: .utf8), nil)
            }
            return (fileName.localURL!, [.removePreviousFile])
        }

        AF.download(url, to: destination).downloadProgress { (progress) in
            print("progress", progress.fractionCompleted)
        }.response {(response) in
            if let error = response.error {
                print(error)
                completion?(nil, LLError(message: error.localizedDescription))
            }
        }
    }
}

// MARK: - Helper extentions
extension URL {

    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }

}

extension String {
    var localURL: URL? {
        get {
            guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
            return documentsURL.appendingPathComponent(self)
        }
    }
}
