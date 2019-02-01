//
//  ViewController.swift
//  MapKit_Dimo
//
//  Created by Ahmed El-Diftar on 1/29/19.
//  Copyright © 2019 MMD. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var map: MKMapView!
    
    var location = CLLocationCoordinate2DMake(30.0405125,31.2174571)
    var camera = MKMapCamera()
    
    @IBAction func segmented(_ sender: Any) {
        
        var segmented = sender as! UISegmentedControl
        
        switch segmented.selectedSegmentIndex {
        case 0:
            location = CLLocationCoordinate2DMake(30.0405125,31.2174571)
            updateMapCameraWith(heading: 180, altitute: 1000.0)
            break
        case 1:
            location = CLLocationCoordinate2DMake(30.0472733,31.2053506)
            updateMapCameraWith(heading: 45.0, altitute: 5000.0)
            break
        case 2:
            location = CLLocationCoordinate2DMake(52.4456775,-1.8840589)
            updateMapCameraWith(heading: 90.0, altitute: 50)
            break
        case 3:
            location = CLLocationCoordinate2DMake(52.4799864,-1.8363626)
            updateMapCameraWith(heading: 180.0, altitute: 10)
            break
        case 4:
            location = CLLocationCoordinate2DMake(27.9881199,86.9162203)
            updateMapCameraWith(heading: -20.0, altitute: 1000)
            break
        default:
            location = CLLocationCoordinate2DMake(30.0405125,31.2174571)
            updateMapCameraWith(heading: 45.0, altitute: 45)
        }
        
//        updateMapWithRegion(distanec: 100)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateMapWithRegion(distanec: 100) // 100 meters around
    updateMapCameraWith(heading: 0, altitute: 200.0)
    }

    func updateMapWithRegion(distanec: CLLocationDistance) {
        var region = MKCoordinateRegion(center: location, latitudinalMeters: distanec, longitudinalMeters: distanec)
        map.region = region
    }
    
    func updateMapCameraWith(heading : CLLocationDirection , altitute : CLLocationDistance) {
        camera.centerCoordinate = location
        camera.heading = heading
        camera.altitude = altitute
        map.camera = camera
    }

}

