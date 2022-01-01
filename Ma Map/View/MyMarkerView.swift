//
//  MyMarkerView.swift
//  Ma Map
//
//  Created by bilal on 01/01/2022.
//

import Foundation
import MapKit


class MyMarkerView: MKMarkerAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.glyphImage = UIImage(systemName: "house.fill")
        self.canShowCallout = true
        self.markerTintColor = .systemMint
    }
    
    
}
