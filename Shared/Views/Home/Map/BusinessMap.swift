//
//  BusinessMap.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 10/09/2022.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    @Binding var selectedBusiness: Business?
    
    var locations: [MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation]()
        
        // Create a  set of annotations from list of businesses
        for business in model.restaurants + model.sights {
            
            // If business has lat and long, create MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                // Create  new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Make user show up on map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on business
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    // MARK: - Coordinator class
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMap
        
        init(map: BusinessMap) {
            
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // If annotation is user's blue dot, return nil
            if annotation is MKUserLocation {
                
                return nil
            }
            
            // Check if there's a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseID)
            
            if annotationView == nil {
                
                // Create a new annotation view
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseID)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                
                // We have a reusable one
                annotationView!.annotation = annotation
            }
            
            // Return view
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            // User tapped on annotation view
            
            // Get business object that this annotation represents
            // Loop through businesses in model and find a match
            for business in map.model.restaurants + map.model.sights {
                
                if business.name == view.annotation?.title {
                    
                    // Set selectedBusiness property to that business object
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }
}
