//
//  LocationServiceTests.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/6/22.
//

import XCTest
@testable import LocationWikipedia

class LocationServiceTests: XCTestCase {
    var urlSession: URLSession!

    
    func test_getLocations() throws {
        let url = anyURL()
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
            return (HTTPURLResponse(), Data("any data".utf8))
        }
        
        makeSUT().getRquest(from: url, completion: { _ in })
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
}
