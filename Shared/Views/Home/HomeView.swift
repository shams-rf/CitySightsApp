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
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            // Determine whether to show list or map view
            if !isMapShowing {
                
                // Show list
                VStack (alignment: .leading) {
                    
                    HStack {
                        
                        Image(systemName: "mappin")
                        
                        Text("San Francisco")
                        
                        Spacer()
                        
                        Text("Switch to map view")
                    }
                    
                    Divider()
                    
                    BusinessList()
                }
            }
            else {
                
                // Show map
            }
        }
        else {
            
            // Show spinner while waiting for data
            ProgressView()
        }
    }
}
