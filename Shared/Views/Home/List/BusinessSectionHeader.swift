//
//  BusinessSectionHeader.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 01/09/2022.
//

import SwiftUI

struct BusinessSectionHeader: View {
    
    var title: String
    
    var body: some View {
        
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 45)
            
            Text(title)
                .font(.headline)
        }
    }
}
