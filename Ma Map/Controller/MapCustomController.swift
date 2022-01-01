//
//  MapCustomController.swift
//  Ma Map
//
//  Created by bilal on 01/01/2022.
//

import UIKit
import MapKit

class MapCustomController: UIViewController {

    @IBOutlet weak var prMap: MKMapView!
    @IBOutlet weak var prSegmented: UISegmentedControl!

    
    var locManager = CLLocationManager()
    var followUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.delegate = self
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        prMap.showsUserLocation = true
        setup()
        
        myAnotations.forEach { annotation in
            let newAnnotation = CustomAnnotation(annotation)
            prMap.addAnnotation(newAnnotation)
        }
        
    }
    
    func setRegion(_ coordinate: CLLocationCoordinate2D) {
//        prMap.setCenter(coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        prMap.setRegion(region, animated: true)
    }
    
    
    @IBAction func segmentedBtn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            prMap.mapType = .standard
        case 1:
            prMap.mapType = .satellite
        default:
            prMap.mapType = .hybrid
        }
    }
    
    
}




extension MapCustomController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways: print("always")
        case .authorizedWhenInUse : print("when in use")
        case .denied : print("Refusé")
        case .notDetermined: print("pas decidé")
        case .restricted: print("restricted")
        default: print("inconu")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let coordinate = location.coordinate
        setRegion(coordinate)
        if !followUser {
            locManager.stopUpdatingLocation()
        }
    }
    
    
    //.
}



extension MapCustomController: MKMapViewDelegate {
    
    func setup() {
        prMap.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let id = "ID"
        if let customAnnotation = annotation as? CustomAnnotation {
            var view : CustoAnnotationView
            if let dequeue = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? CustoAnnotationView {
                dequeue.annotation = customAnnotation
                view = dequeue
            } else {
                view = CustoAnnotationView(annotation: annotation, reuseIdentifier: id)
                view.canShowCallout = true
            }
            return view
        }
        return markerAnnotationView(annotation, id)
    }
    
    func markerAnnotationView(_ annotation: MKAnnotation, _ id: String) -> MKMarkerAnnotationView {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
        marker.glyphImage = UIImage(systemName: "house.fill")
        marker.markerTintColor = .systemMint
        return marker
    }
    
}
