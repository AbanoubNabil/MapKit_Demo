//
//  MapView+Annotation.swift
//  MapKit_Dimo
//
//  Created by Ahmed El-Diftar on 2/27/19.
//  Copyright © 2019 MMD. All rights reserved.
//

import Foundation
import MapKit

extension ViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKAnnotationView()
        guard let annotation = annotation as? PizzaAnnotation else {
            return nil
        }
        if let dequedView = map.dequeueReusableAnnotationView(withIdentifier: "Pin"){
            annotationView = dequedView
        }else{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
//        annotationView.pinTintColor = UIColor.blue
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "pizza pin")
        
        let paragraph = UILabel()
        paragraph.numberOfLines = 0
        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.historyText
        annotationView.detailCalloutAccessoryView = paragraph
        annotationView.leftCalloutAccessoryView = UIImageView(image: annotation.pizzaPhoto)
        return annotationView
    }
}

class PizzaAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identifier  = "Pin"
    var historyText = ""
    var pizzaPhoto : UIImage?
    
    init(coordinate: CLLocationCoordinate2D , title: String?, subtitle: String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
    }
    
}
