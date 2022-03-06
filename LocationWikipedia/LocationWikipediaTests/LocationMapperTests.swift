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
    
    // MARK: - Helpers
    
    private func makeJson(_ items: [[String: Any]]) -> Data {
        let json = ["locations": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}

extension HTTPURLResponse {
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
