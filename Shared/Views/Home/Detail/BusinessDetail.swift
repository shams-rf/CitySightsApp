//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 08/09/2022.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    @State private var showDirections = false
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading, spacing: 0) {
                
                GeometryReader() { geo in
                    
                    // Business image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .scaledToFill()
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                // Open/closed indicator
                ZStack (alignment: .leading) {
                    
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .padding(.leading)
                }
            }
            
            Group {
                
                BusinessTitle(business: business)
                    .padding()
                
                Divider()
                
                // Phone
                HStack {
                    
                    Text("Phone:")
                        .bold()
                    
                    Text(business.displayPhone ?? "")
                    
                    Spacer()
                    
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                
                // Reviews
                HStack {
                    
                    Text("Reviews:")
                        .bold()
                    
                    Text(String(business.reviewCount ?? 0))
                    
                    Spacer()
                    
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
                
                // Website
                HStack {
                    
                    Text("Website:")
                        .bold()
                    
                    Text(business.url ?? "")
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
            }
            
            Group {
                
                // Button to show directions
                Button(action: {
                    
                    // Show directions
                    showDirections = true
                }, label: {
                    
                    ZStack {
                        
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        
                        Text("Get Directions")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
                .padding()
                .sheet(isPresented: $showDirections) {
                    
                    DirectionsView(business: business)
                }
            }
        }
    }
}
