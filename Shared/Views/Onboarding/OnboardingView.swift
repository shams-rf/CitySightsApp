//
//  OnboardingView.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 13/09/2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var tabSelection = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
        VStack {
            
            // Tab view
            TabView(selection: $tabSelection) {
                
                // First tab
                VStack (spacing: 20) {
                    
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    
                    Text("City Sights helps you find the best of your city!")
                }
                .tag(0)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                
                // Second tab
                VStack (spacing: 20) {
                    
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    
                    Text("We'll show you the best restaurants, venues and more, based on your location!")
                }
                .tag(1)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .padding()
            
            // Button
            Button(action: {
                
                // Detect which tab user is currently on
                if tabSelection == 0 {
                    
                    tabSelection = 1
                }
                else {
                    
                    // Request for geolocation permission
                    model.requestGeolocationPermission()
                }
            }, label: {
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                }
            })
            .tint(tabSelection == 0 ? blue : turquoise)
            .padding()
            
            Spacer()
        }
        .background(tabSelection == 0 ? blue : turquoise)
        .ignoresSafeArea()
    }
}
