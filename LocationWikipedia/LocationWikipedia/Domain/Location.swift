//
//  LocationDTO.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

public struct Location: Equatable {
    public let name: String?
    public let coordinators: (latitude: Double, longitude: Double)
    
    public init(name: String?, coordinators: (latitude: Double, longitude: Double)) {
        self.name = name
        self.coordinators = coordinators
    }

    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name && lhs.coordinators == rhs.coordinators
    }
}
