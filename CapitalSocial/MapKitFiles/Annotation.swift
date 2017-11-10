//
//  Annotation.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 06/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(_ title: String, _ locationName: String, _ coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
}
