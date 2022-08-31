//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Shamsuddin Refaei on 31/08/2022.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    
    var center = Coordinate()
}
