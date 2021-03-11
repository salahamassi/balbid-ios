//
//  ShippingMapViewController.swift
//  balbid
//
//  Created by Memo Amassi on 01/02/2021.
//

import UIKit
import MapKit

class ShippingMapViewController: BaseViewController {
    
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var countryAndCityLabel: UILabel!
    @IBOutlet weak var locationInfoContainer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locateMyLocationButton: UIButton!
    @IBOutlet weak var confirmLocation: UIButton!
    var userLocation: CLLocationCoordinate2D!
    var selectedLocation: CLLocationCoordinate2D?

    let annotation = MKPointAnnotation()
    weak var delegate: ShippingMapViewControllerDelegate?
    
    override var mustClearNavigationBar: Bool {
        true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationInfo()
        setupNav()
        setupView()
        setupMapView()
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
        selectedLocation = userLocation
        getPositionDetail()
        let center = CLLocationCoordinate2D(latitude: selectedLocation?.latitude ?? 0.0, longitude: selectedLocation?.longitude ?? 0.0)
        mapView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        mapView.delegate = self
    }
    
    private func getPositionDetail() {
        let location = CLLocation(latitude: selectedLocation?.latitude ?? 0.0, longitude: selectedLocation?.longitude ?? 0.0)
        location.geocode { [weak self] (placeMarks, error) in
            if error == nil {
                guard let placeMark = placeMarks?.first else {
                    return
                }
                
                self?.countryAndCityLabel.text = (placeMark.country ?? "UnKnown") + ", " + (placeMark.locality ?? "UnKnownn")
                self?.locationDetailLabel.text = (placeMark.subLocality ?? "UnKnown") + ", " +  (placeMark.thoroughfare ??  "UnKnown")  + ", " 
                self?.locationDetailLabel.text! += (placeMark.subThoroughfare ?? "UnKnown")
            }
        }
    }
    
    private func setLocationInfo(){
        userLocation = LocationManager.shared.currentLocation?.coordinate
    }
    
    @IBAction func loacateMyLocation(_ sender: Any){
        mapView.setRegion(MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        annotation.coordinate = userLocation
    }
    
    @IBAction func confirmLocation(_ sender: Any) {
        delegate?.didSelectLocation(latitude: selectedLocation?.latitude ?? 0.0, longitude: selectedLocation?.longitude ?? 0.0)
        router?.popViewController()
    }

}


extension ShippingMapViewController: MKMapViewDelegate  {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard  annotation is MKPointAnnotation else { return nil}
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.isDraggable = true

        }else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        print(newState.rawValue)
        switch newState {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            view.dragState = .none
        case .none:
            getPositionDetail()
            selectedLocation = view.annotation?.coordinate
        
        default: break
        }
    }
    

}


protocol ShippingMapViewControllerDelegate: class {
    func  didSelectLocation(latitude: Double, longitude: Double)
}
