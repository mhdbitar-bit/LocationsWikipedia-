//
//  LocationMapper.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

public final class LocationMapper {
    private struct LocationResponse: Decodable {
        private let locations: [LocationItem]
        
        private struct LocationItem: Decodable {
            let name: String?
            let lat: Double
            let long: Double
        }
        
        var items: [Location] {
            locations.map { Location(
                name: $0.name,
                coordinators: (latitude: $0.lat, longitude: $0.long)
            ) }.compactMap { $0 }
        }
    }

    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Location] {
        guard response.statusCode == 200, let locations = try? JSONDecoder().decode(LocationResponse.self, from: data) else {
            throw Error.invalidData
        }
        
        return locations.items
    }
}


