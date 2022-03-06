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
        let json = ["locations": []]
        let data = try! JSONSerialization.data(withJSONObject: json)
        
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try LocationMapper.map(data, from: HTTPURLResponse(
                    url: URL(string: "http://any-url.com")!,
                    statusCode: code,
                    httpVersion: nil,
                    headerFields: nil)!)
            )
        }
    }
}
