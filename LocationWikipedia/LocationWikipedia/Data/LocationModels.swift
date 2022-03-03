//
//  LocationModels.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

struct LocationResponse: Codable {
    let locations: [Location]
}

struct Location: Codable {
    let name: String
    let lat: Double
    let long: Double
}
