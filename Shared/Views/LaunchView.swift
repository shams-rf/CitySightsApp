//
//  ContentView.swift
//  Shared
//
//  Created by Shamsuddin Refaei on 27/08/2022.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect authorization status of geolocating user
        if model.authorizationState == .notDetermined {
            
            // If undetermined, show onboarding
            OnboardingView()
        }
        else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            
            // If approved, show home view
            HomeView()
        }
        else {
            
            // If denied, show denied view
            LocationDeniedView()
        }
    }
}
