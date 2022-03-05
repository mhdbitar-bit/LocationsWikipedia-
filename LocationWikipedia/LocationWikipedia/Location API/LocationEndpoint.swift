//
//  LocationEndpoint.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

public enum LocationEndpoint {
    case getLocations
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .getLocations:
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/abnamrocoesd/assignment-ios/main/locations.json"
            components.queryItems = []
            return components.url!
        }
    }
}
