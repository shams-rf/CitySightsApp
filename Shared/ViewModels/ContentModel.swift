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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
    }
    
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        var urlComponents = URLComponents(string: Constants.apiUrl)
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
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    do {
                        
                        // Parse JSON
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            
                            // Assign results to appropriate property
                            switch category {
                                
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                                
                            case Constants.sightsKey:
                                self.sights = result.businesses
                                
                            default:
                                break
                            }
                        }
                    }
                    catch {
                        
                        print(error)
                    }
                }
            }
            
            // Start data task
            dataTask.resume()
        }
    }
}
