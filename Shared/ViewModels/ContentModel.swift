//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 30/08/2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Set content model as delegate of location manager
        locationManager.delegate = self
        
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating user
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us location of user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // We have a location
            // Stop requesting location after we get it once
            locationManager.stopUpdatingLocation()
            
            // If we have user's location, pass into Yelp API
            getBusinesses(category: "restaurants", location: userLocation!)
        }
    }
    
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer PkQHcpsYx_bTSiX0E79DU0XRo8pysX2MtQ7RlnFpNGgHw6zDIXY3v8y6HiiNO7iZaD1zxFEWRmLay--1UP7DU_b0kcyP8m5qy3urzbV1JqAi1WiDIB_rnIYJ7xYOY3Yx", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    print(response)
                }
            }
            
            // Start data task
            dataTask.resume()
        }
    }
}
