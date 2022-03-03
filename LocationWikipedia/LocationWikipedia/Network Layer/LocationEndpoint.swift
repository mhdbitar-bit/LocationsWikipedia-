//
//  LocationEndpoint.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

enum LocationEndpoint {
    case getLocations
}

extension LocationEndpoint: Endpoint {
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "raw.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
        case .getLocations:
            return "/abnamrocoesd/assignment-ios/main/locations.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLocations:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getLocations:
            return "GET"
        }
    }
}
