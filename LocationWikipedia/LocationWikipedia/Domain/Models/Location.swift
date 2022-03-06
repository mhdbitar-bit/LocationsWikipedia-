//
//  LocationDTO.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

public struct Location: Equatable {
    let name: String?
    let coordinators: (latitude: Double, longitude: Double)

    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name && lhs.coordinators == rhs.coordinators
    }
}
