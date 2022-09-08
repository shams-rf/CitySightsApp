//
//  BusinessSection.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 01/09/2022.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        Section (header: BusinessSectionHeader(title: title)) {
            
            ForEach(businesses) { business in
                
                NavigationLink(destination: {
                    
                    BusinessDetail(business: business)
                }, label: {
                    
                    BusinessRow(business: business)
                })
            }
        }
    }
}
