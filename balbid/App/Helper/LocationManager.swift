//
//  LocationManager.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import CoreLocation
import AppRouter

class LocationManager: NSObject, CLLocationManagerDelegate {

    private lazy var locationManager = CLLocationManager()

    var currentLocation: CLLocation?

    class var shared: LocationManager {
        struct Static {
            static let instance = LocationManager()
        }
        return Static.instance
    }

    func startTracking(router: AppRouter?) {
        locationManager.delegate = self
        locationManager.distanceFilter = 200
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if location.coordinate.latitude == 0 || location.coordinate.longitude == 0 { return }
        self.currentLocation = location
        NotificationCenter.default.post(name: .BALBIDLocationUpdated, object: nil, userInfo: ["currentLocation": location])
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            NotificationCenter.default.post(name: .BALBIDLocationAccessRestricted, object: nil)
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            fatalError("unkown authorization status")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ProviderTracker locationManager fail with error \(error)")
    }

}
