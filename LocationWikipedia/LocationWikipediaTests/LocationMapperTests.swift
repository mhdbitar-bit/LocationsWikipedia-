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
                try LocationMapper.map(json, from: HTTPURLResponse(
                    url: URL(string: "http://any-url.com")!,
                    statusCode: code,
                    httpVersion: nil,
                    headerFields: nil)!)
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try LocationMapper.map(invalidJSON, from: HTTPURLResponse(
                url: URL(string: "http://any-url.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!)
        )
    }
    
    func test_map_deliversNoLocationsOn200HTTPResponseWithEmptyJsonList() throws {
        let json = makeJson([])
        let result = try LocationMapper.map(json, from: 
            HTTPURLResponse(
            url: URL(string: "http://any-url.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)!)
        
        XCTAssertEqual(result, [])
    }
    
    // MARK: - Helpers
    
    private func makeJson(_ items: [[String: Any]]) -> Data {
        let json = ["locations": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}
