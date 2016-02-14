//
//  LocationManager.swift
//  Yelp
//
//  Created by Andre Oriani on 2/12/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    
    private var started = false
    //Default location is SF
    private var latitude: CLLocationDegrees = 37.785771
    private var longitude: CLLocationDegrees = -122.406165
    private var locationManager:CLLocationManager = CLLocationManager()
    
    private override init() {
        super.init()
    }
    
    func start() {
        if (!started) {
            started = true
            print("We started")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                print("We have a initial fix")
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
            }
        }
    }
    
    func getLastKnownLocation() -> (lat: CLLocationDegrees, lon: CLLocationDegrees) {
        return (latitude, longitude)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            print("Got location permission")
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                print("We have a initial fix")
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("We have a new fix")
        if locations.count > 0 {
            let lastLocation = locations[locations.count - 1]
            latitude = lastLocation.coordinate.latitude
            longitude = lastLocation.coordinate.longitude
        }
    }
}
