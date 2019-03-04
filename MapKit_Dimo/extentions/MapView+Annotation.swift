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
        paragraph.numberOfLines = 1
        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.subtitle
        annotationView.detailCalloutAccessoryView = paragraph
        paragraph.adjustsFontSizeToFitWidth = true
        annotationView.leftCalloutAccessoryView = UIImageView(image: annotation.pizzaPhoto)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = AnnotationDetailViewController(nibName: "AnnotationDetailViewController", bundle: nil)
        vc.annotation = view.annotation as! PizzaAnnotation
        present(vc, animated: false,completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle{
            let renderer = MKCircleRenderer(circle: circle)
            renderer.fillColor = UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 0.1)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 1.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

class PizzaAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identifier  = "Pin"
    var historyText = ""
    var pizzaPhoto = #imageLiteral(resourceName: "pizza pin")
    
    init(coordinate: CLLocationCoordinate2D , title: String?, subtitle: String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
    }
    
}
