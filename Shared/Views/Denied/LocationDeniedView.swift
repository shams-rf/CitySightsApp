//
//  LocationDeniedView.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 13/09/2022.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 148/255)
    
    var body: some View {
        
        VStack (spacing: 20) {
            
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide you with the best sights in the city.You can change your decision at any time in Settings.")
            
            Spacer()
            
            Button(action: {
                
                // Open settings by gettings settings url
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        
                        // If we can open this settings url, go ahead
                        UIApplication.shared.open(url)
                    }
                }
            }, label: {
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }
            })
            .padding()
            
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea()
    }
}
