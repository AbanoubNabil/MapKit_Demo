//
//  File.swift
//  MapKit_Dimo
//
//  Created by Ahmed El-Diftar on 3/5/19.
//  Copyright © 2019 MMD. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension ViewController : CLLocationManagerDelegate{
    
    func enableLocationServeces() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            map.setUserTrackingMode(.follow, animated: true)
            locationManager.startUpdatingLocation()
        }
    }
    
    func disableLocationServeces() {
        locationManager.stopUpdatingLocation()
    }
    
    func setupCoreLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways , .authorizedWhenInUse:
            enableLocationServeces()
        
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("authorized")
            break
        case .denied, .restricted:
            print("not authorized")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let new_location = locations.last
        location = new_location!.coordinate
        let displayString = "\(new_location?.timestamp) Coord: \(location) Alt: \(new_location!.altitude) meters"
        print(displayString)
        updateMapWithRegion(distanec: 200)
        let pizzaPin = PizzaAnnotation(coordinate: location, title: displayString, subtitle: "")
        map.addAnnotation(pizzaPin)
    }

}
