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
        
    }
    
    func disableLocationServeces() {
        
    }
    
    func setupCoreLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways:
            enableLocationServeces()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            print("authorized")
            break
        case .denied, .restricted:
            print("not authorized")
        default:
            break
        }
    }

}
