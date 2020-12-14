//
//  ImageWrapper.swift
//  MSA
//
//  Created by Salah Amassi on 4/10/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

public struct MediaWrapper{
   public let url: URL
   public let indexPath: IndexPath
    
    public init(url: URL, indexPath: IndexPath){
        self.url = url
        self.indexPath = indexPath
    }
}
