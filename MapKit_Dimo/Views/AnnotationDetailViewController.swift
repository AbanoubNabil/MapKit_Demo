//
//  AnnotationDetailViewController.swift
//  PizzaHistoryMap
//
//  Created by Steven Lipton on 7/20/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import MapKit

class AnnotationDetailViewController: UIViewController {
    var annotation:PizzaAnnotation!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pizzaPhoto: UIImageView!
    @IBOutlet weak var historyText: UITextView!
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = annotation.title
        pizzaPhoto.image = annotation.pizzaPhoto
        historyText.text = annotation.historyText
        placeMark(annotation: annotation) { (placemark) in
            if let placeMark = placemark{
                var locationString = ""
                if let city = placeMark.locality{
                    locationString += city
                }
                if let state = placeMark.administrativeArea{
                    locationString += state
                }
                if let country = placeMark.country{
                    locationString += country
                }
                self.historyText.text = locationString + "\n\n" + self.annotation.historyText
            }else{
                print("place mark not found")
            }
            
        }
    }

    func placeMark(annotation: PizzaAnnotation, completion: @escaping (CLPlacemark?) -> Void) {
        let coordinate = annotation.coordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemarks = placemarks{
                completion(placemarks.first)
            }else{
                completion(nil)
            }
        }
    }

}
