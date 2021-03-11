//
//  Extension+CCLocation.swift
//  balbid
//
//  Created by Apple on 11/03/2021.
//

import Foundation
import CoreLocation

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}
