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
 Chatham: 42.4056555,-82.1860369
 beverly Hils: 34.0674607 , -118.3977309
 
 208 S. Beverly Drive Beverly Hills CA:34.0647691,-118.3991328
 2121 N. Clark St Chicago IL: 41.9206921,-87.6375361
 
 */

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var changePich: UIButton!
    
    var location = CLLocationCoordinate2DMake(40.8367321 , 14.2468856)
    var camera = MKMapCamera()
    var pich = 0
    var isOn = false
    
    var locationManager = CLLocationManager()
    
    @IBAction func featyres(_ sender: Any) {
        disableLocationServeces()
        isOn = !isOn
        map.showsBuildings = isOn
        map.showsScale = isOn
        map.showsCompass = isOn
        map.showsPointsOfInterest = isOn
        map.showsTraffic = isOn
    }
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
        
        let segmented = sender as! UISegmentedControl
        disableLocationServeces()
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
            location = CLLocationCoordinate2DMake(34.0674607,-118.3977309)
            updateMapCameraWith(heading: 180.0, altitute: 200)
            break
        case 4:
            location = CLLocationCoordinate2DMake(42.4056555,-82.1860369)
            updateMapCameraWith(heading: -20.0, altitute: 70)
            break
        default:
            location = CLLocationCoordinate2DMake(40.8367321,14.2468856)
            updateMapCameraWith(heading: 45.0, altitute: 1500)
        }
        
//        updateMapWithRegion(distanec: 100)
        
    }
    
    @IBAction func findHereAction(_ sender: Any) {
        setupCoreLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateMapWithRegion(distanec: 100) // 100 meters around
    updateMapCameraWith(heading: 0, altitute: 200.0)
        map.delegate = self
        locationManager.delegate = self
        map.addAnnotations(PizzaHistoryAnnotations().annotations)
        addDeliveryOverlay()
        addPolyline()
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
    
    func addPolyline() {
        let annotations = PizzaHistoryAnnotations().annotations
        let beverlyHills1 = annotations[5].coordinate
        let benerlyHills2 = annotations[6].coordinate
        let boly = MKPolyline(coordinates: [beverlyHills1,benerlyHills2], count: 2)
        boly.title = "BeverlyHills_Line"
        
        var cordenates = [CLLocationCoordinate2D]()
        for annotation in PizzaHistoryAnnotations().annotations {
            cordenates.append(annotation.coordinate)
        }
        let grandTour = MKPolyline(coordinates: cordenates, count: cordenates.count)
        grandTour.title = "grandTour"
        
        map.addOverlays([boly,grandTour])
        
    }
    func addDeliveryOverlay()  {
        for annotation in map.annotations {
            if let annotation = annotation as? PizzaAnnotation{
                let circle = MKCircle(center: annotation.coordinate, radius: annotation.deliveryDistance)
                map.addOverlay(circle)
            }
        }
    }

}

