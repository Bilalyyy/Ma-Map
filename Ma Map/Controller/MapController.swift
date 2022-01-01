//
//  ViewController.swift
//  Ma Map
//
//  Created by bilal on 01/01/2022.
//

import UIKit
import MapKit


class MapController: UIViewController {
    
    
    @IBOutlet weak var prMap: MKMapView!
    @IBOutlet weak var prSegmented: UISegmentedControl!
    @IBOutlet weak var prFollowBtn: UIBarButtonItem!
    @IBOutlet weak var prCenterBtn: UIBarButtonItem!
    
    
    var locManager = CLLocationManager()
    var followUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.delegate = self
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        prMap.showsUserLocation = true
        setup()
        /*
        let anotation = MKPointAnnotation()
        anotation.title = paris.name
        anotation.coordinate = CLLocationCoordinate2D(latitude: paris.lat, longitude: paris.lon)
        
        prMap.addAnnotation(anotation)
         */
        
        myAnotations.forEach { annotation in
            let newAnnotation = MKPointAnnotation()
            newAnnotation.title = annotation.name
            newAnnotation.coordinate = CLLocationCoordinate2D(latitude: annotation.lat, longitude: annotation.lon)
            
            prMap.addAnnotation(newAnnotation)
        }
        
    }
    
    func setRegion(_ coordinate: CLLocationCoordinate2D) {
//        prMap.setCenter(coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        prMap.setRegion(region, animated: true)
    }
    
    func updateBtn() {
        prCenterBtn.isEnabled = !followUser
        let image = followUser ? "location.slash.fill" : "location.fill"
        prFollowBtn.image = UIImage(systemName: image)
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
    
    @IBAction func centerBtn(_ sender: Any) {
        locManager.startUpdatingLocation()
    }
    
    @IBAction func followBtn(_ sender: Any) {
        followUser.toggle()
        updateBtn()
        followUser ? locManager.startUpdatingLocation() : locManager.stopUpdatingLocation()
    }
    //.
}




extension MapController: CLLocationManagerDelegate {
    
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



extension MapController: MKMapViewDelegate {
    
    func setup() {
        prMap.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let id = "ID"
        if let customAnnotation = annotation as? CustomAnnotation {
            var view : MyMarkerView
            if let dequeue = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MyMarkerView {
                dequeue.annotation = customAnnotation
                view = dequeue
            } else {
                view = MyMarkerView(annotation: annotation, reuseIdentifier: id)
                view.canShowCallout = true
            }
            return view
        }
        return MyMarkerView(annotation: annotation, reuseIdentifier: id)
    }
    
}
