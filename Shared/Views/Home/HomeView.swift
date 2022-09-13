//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 01/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness: Business?
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                // Determine whether to show list or map view
                if !isMapShowing {
                    
                    // Show list
                    VStack (alignment: .leading) {
                        
                        HStack {
                            
                            Image(systemName: "mappin")
                            
                            Text(model.placemark?.locality ?? "")
                            
                            Spacer()
                            
                            Button("Switch to map view") {
                                
                                self.isMapShowing = true
                            }
                        }
                        
                        Divider()
                        
                        ZStack (alignment: .top) {
                            
                            BusinessList()
                            
                            HStack {
                                
                                Spacer()
                                
                                YelpAttribution(link: "https://yelp.com")
                            }
                            .padding(.trailing, -20)
                        }
                    }
                    .navigationBarHidden(true)
                    .padding([.horizontal, .top])
                }
                else {
                    
                    ZStack (alignment: .top) {
                        
                        // Show map
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                
                                BusinessDetail(business: business)
                            }
                        
                        // Rectangle overlay
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack {
                                
                                Image(systemName: "mappin")
                                
                                Text(model.placemark?.locality ?? "")
                                
                                Spacer()
                                
                                Button("Switch to list view") {
                                    
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .navigationBarHidden(true)
                }
            }
        }
        else {
            
            // Show spinner while waiting for data
            ProgressView()
        }
    }
}
