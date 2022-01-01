//
//  CustomAnnotation.swift
//  Ma Map
//
//  Created by bilal on 01/01/2022.
//

import Foundation
import MapKit


class CustomAnnotation: NSObject, MKAnnotation {
    
    var location: Location
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(_ location: Location) {
        self.location = location
        self.title = self.location.name
        self.subtitle = nil // pas besoin...
        self.coordinate = CLLocationCoordinate2D(latitude: self.location.lat,
                                                 longitude: self.location.lon)
    }
}
