//
//  MapLocation.swift
//  maps
//
//  Created by Preksha Koirala on 2/24/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class mapLocation: NSObject, MKAnnotation {
    
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let placeId: String
    let subtitle: String?
    let image: String?
   
    
    override init() {
        self.title = "title"
        self.placeId = "placeId String"
        self.coordinate = CLLocationCoordinate2D(latitude: 30, longitude: 100)
        self.subtitle = "subtitle string"
        self.image = "image"
        super.init()
     
        
    }
    init(title: String, coordinate:CLLocationCoordinate2D, placeId: String, subtitle: String, image: String){
        
        self.subtitle = subtitle
        self.title = title
        self.coordinate = coordinate
        self.placeId = placeId
        self.image = image
        super.init()
        
    }
    
}
