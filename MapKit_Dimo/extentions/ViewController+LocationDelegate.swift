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
        if CLLocationManager.headingAvailable() {
            locationManager.startUpdatingHeading()
        }else{
            print("magnetometer not supported")
        }
        monitorRegions(center: onRamp, radios: 200, id: "1")
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
        let speed_heading_string = "Heading :\(heading) at speed/: \((new_location?.speed)! * 2.23694) mph"
        print(speed_heading_string)
        let displayString = "\(new_location?.timestamp) Coord: \(location) Alt: \(new_location!.altitude) meters"
        print(displayString)
        updateMapWithRegion(distanec: 200)
        let pizzaPin = PizzaAnnotation(coordinate: location, title: displayString, subtitle: "")
        map.addAnnotation(pizzaPin)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading.magneticHeading
    }
    
    func monitorRegions(center : CLLocationCoordinate2D, radios: CLLocationDistance, id: String) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
                let region = CLCircularRegion(center: center, radius: radios, identifier: id)
                region.notifyOnExit = true
                region.notifyOnEntry = true
                locationManager.startMonitoring(for: region)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let circularRegion = region as! CLCircularRegion
        if circularRegion.identifier == "1" {
            let alert = UIAlertController(title: "you are getting out", message: "you are on the ramp", preferredStyle: .alert)
            let ok = UIAlertAction(title: "dismiss", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let circularRegion = region as! CLCircularRegion
        if circularRegion.identifier == "1" {
            let alert = UIAlertController(title: "you are getting in", message: "you are coming to the ramp", preferredStyle: .alert)
            let ok = UIAlertAction(title: "dismiss", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }

}
