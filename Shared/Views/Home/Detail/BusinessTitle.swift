//
//  BusinessTitle.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 12/09/2022.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            // Business name
            Text(business.name!)
                .font(.title)
                .bold()
            
            if business.location?.displayAddress != nil {
                
                // Loop through display address
                ForEach (business.location!.displayAddress!, id: \.self) { displayLine in
                    
                    Text(displayLine)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0)")
        }
    }
}
