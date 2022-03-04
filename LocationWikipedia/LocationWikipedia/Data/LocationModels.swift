//
//  LocationModels.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

public final class LocationMapper: Decodable {
    private struct LocationResponse: Decodable {
        private let locations: [LocationItem]
        
        private struct LocationItem: Decodable {
            let name: String
            let lat: Double
            let long: Double
        }
        
        var items: [LocationDTO] {
            locations.map { LocationDTO(name: $0.name, latitude: $0.lat, longitude: $0.long) }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [LocationDTO] {
        guard response.statusCode == 200, let locations = try? JSONDecoder().decode(LocationResponse.self, from: data) else {
            throw Error.invalidData
        }
        
        return locations.items
    }
}


