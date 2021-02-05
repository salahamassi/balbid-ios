//
//  ShippingMapViewController.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit
import MapKit

class ShippingMapViewController: BaseViewController {
    
    @IBOutlet weak var locationInfoContainer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locateMyLocationButton: UIButton!
    @IBOutlet weak var confirmLocation: UIButton!
    var userLocation: CLLocationCoordinate2D!
    let annotation = MKPointAnnotation()
    
    override var mustClearNavigationBar: Bool {
        true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
        setupMapView()
        setLocationInfo()
    }
    
    private func setupNav(){
        title = "Shipping Addresses"
        (navigationController as! AppNavigationController).restyleBackButton()
    }
    
    private func setupView(){
        locationInfoContainer.withShadow(color: .black, alpha: 0.16, x: 0, y: 3, blur: 11, spread: 0)
        locateMyLocationButton.withShadow(color: .black, alpha: 0.16, x: 0, y: 3, blur: 11, spread: 0)
        confirmLocation.withCornerRadius(12, corners: [.topLeft,.topRight])
      
    }
    
    private func setupMapView(){
        let center = CLLocationCoordinate2D(latitude: 21.4359571, longitude: 39.9866319)
        mapView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    
    private func setLocationInfo(){
        userLocation = LocationManager.shared.currentLocation?.coordinate
    }
    
    @IBAction func loacateMyLocation(_ sender: Any){
        mapView.setRegion(MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        annotation.coordinate = userLocation
    }
    
    @IBAction func confirmLocation(_ sender: Any) {
        router?.popViewController()
    }
    
    

}
