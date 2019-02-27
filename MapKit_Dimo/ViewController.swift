//
//  ViewController.swift
//  MapKit_Dimo
//
//  Created by Ahmed El-Diftar on 1/29/19.
//  Copyright © 2019 MMD. All rights reserved.
//

import UIKit
import MapKit
/*
 Naples: 40.8367321 , 14.2468856
 New York: 40.7216294 , -73.995453
 Chicago: 41.892479 , -87.6267592
 Chatham: beverly Hils: 34.0674607 , -118.3977309
 */

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var changePich: UIButton!
    
    var location = CLLocationCoordinate2DMake(30.0405125,31.2174571)
    var camera = MKMapCamera()
    var pich = 0
    
    @IBAction func mapType(_ sender: Any) {
        switch map.mapType {
        case .standard:
            map.mapType = .satellite
        case .satellite:
            map.mapType = .hybrid
        case .hybrid:
            map.mapType = .satelliteFlyover
        case .satelliteFlyover:
            map.mapType = .hybridFlyover
        case .hybridFlyover:
            map.mapType = .mutedStandard
        case .mutedStandard:
            map.mapType = .standard
        }
        
    }
    
    @IBAction func changePichaction(_ sender: Any) {
        pich = (pich + 15) % 90
        map.camera.pitch = CGFloat(pich)
        changePich.setTitle("\(pich)ْ", for: .normal)
    }
    
    @IBAction func segmented(_ sender: Any) {
        
        var segmented = sender as! UISegmentedControl
        
        switch segmented.selectedSegmentIndex {
        case 0:
            location = CLLocationCoordinate2DMake(40.8367321 , 14.2468856)
            updateMapCameraWith(heading: 180, altitute: 100.0)
            break
        case 1:
            location = CLLocationCoordinate2DMake(40.7216294 , -73.995453)
            updateMapCameraWith(heading: 245.0, altitute: 250.0)
            break
        case 2:
            location = CLLocationCoordinate2DMake(41.892479 , -87.6267592)
            updateMapCameraWith(heading: 90.0, altitute: 50)
            break
        case 3:
            location = CLLocationCoordinate2DMake(52.4799864,-1.8363626)
            updateMapCameraWith(heading: 180.0, altitute: 200)
            break
        case 4:
            location = CLLocationCoordinate2DMake(34.0674607 , -118.3977309)
            updateMapCameraWith(heading: -20.0, altitute: 70)
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
        camera.pitch = 0.0
        changePich.setTitle("0", for: .normal)
        camera.altitude = altitute
        map.camera = camera
    }

}

