//
//  CustomAnnotationView.swift
//  Ma Map
//
//  Created by bilal on 01/01/2022.
//

import Foundation
import MapKit


class CustoAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        image = UIImage(systemName: "paperplane.fill")
        tintColor = .systemGray //tint de l'accessoir
        leftCalloutAccessoryView = UIImageView(image: UIImage(systemName: "heart.fill"))
        
        let button = UIButton.systemButton(with: UIImage(systemName: "pencil")!, target: self, action: #selector(btnPressed))
        
        rightCalloutAccessoryView = button
    }
    
    @objc func btnPressed() {
        print("ACtion !")
    }
    
}
