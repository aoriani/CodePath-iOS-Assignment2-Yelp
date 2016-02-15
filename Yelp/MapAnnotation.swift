//
//  MapAnnotation.swift
//  Yelp
//
//  Created by Andre Oriani on 2/14/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var business: Business
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(
                latitude: business.location.coordinates.latitude.value.doubleValue,
                longitude: business.location.coordinates.longitude.value.doubleValue)
        }
    }
    
    var title: String? {
        get {
            return business.name
        }
    }
    
    init(business: Business) {
        self.business = business
    }
}