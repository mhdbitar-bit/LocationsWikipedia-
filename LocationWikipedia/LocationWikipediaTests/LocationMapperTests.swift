//
//  LocationMapperTests.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/6/22.
//

import XCTest
@testable import LocationWikipedia

class LocationMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeJson([])
        
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try LocationMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try LocationMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoLocationsOn200HTTPResponseWithEmptyJsonList() throws {
        let json = makeJson([])
        let result = try LocationMapper.map(json, from: 
            HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversLocationsOn200HTTPResponseWithJSONItems() throws {
        let location1 = makelocation(name: "name 1", lat: 10.0, long: 2.0)
        
        let location2 = makelocation(name: "name 2", lat: 10.0, long: 2.0)
        
        let json = makeJson([location1.json, location2.json])
        
        let result = try LocationMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [location1.model, location2.model])
        
    }
    
    // MARK: - Helpers
    
    private func makeJson(_ locations: [[String: Any]]) -> Data {
        let json = ["locations": locations]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makelocation(name: String, lat: Double, long: Double) -> (model: Location, json: [String: Any]) {
        let location = Location(name: name, coordinators: (latitude: lat, longitude: long))
        
        let json = [
            "name": name,
            "lat": lat,
            "long": long
        ].compactMapValues { $0 }
        
        return (location, json)
    }
}

private extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(
            url: anyURL(),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil)!
    }
}

func anyURL() -> URL {
    return URL(string: "https://any-url.om")!
}
