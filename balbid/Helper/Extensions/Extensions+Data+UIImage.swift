//
//  Extensions+Data+UIImage.swift
//  MSA
//
//  Created by Salah Amassi on 10/24/20.
//  Copyright © 2020 msa. All rights reserved.
//

import Foundation
import UIKit

extension Data {

    // saves an image, if save is successful, returns its URL on local storage, otherwise returns nil
    func saveImage(name: String = UUID().uuidString+".jpg") -> URL? {
        do {
            let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
            try self.write(to: imageURL)
            return imageURL
        } catch {
            return nil
        }
    }
    

}
