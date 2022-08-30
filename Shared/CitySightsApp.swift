//
//  CitySightsApp.swift
//  Shared
//
//  Created by Shamsuddin Refaei on 27/08/2022.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
