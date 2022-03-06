//
//  LocationEndpointTests.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/6/22.
//

import XCTest
@testable import LocationWikipedia

class LocationEndpointTests: XCTestCase {
    
    func test_location_endpointURL() {
        let baseURl = URL(string: "https://any-url.com")!
        
        let received = LocationEndpoint.getLocations.url(baseURL: baseURl)
        
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "any-url.com", "host")
        XCTAssertEqual(received.path, "/abnamrocoesd/assignment-ios/main/locations.json", "path")
        XCTAssertEqual(received.query, "", "query")    }
}
