//
//  LocationAnnotation.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 21/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import MapKit


// Reference to Week 5 Lab Tutorial

class LocationAnnotation: NSObject, MKAnnotation {
    
    var id: String?
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(id: String, title: String, subtitle: String, lat: Double, long: Double) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        super.init()
    }
    

}
