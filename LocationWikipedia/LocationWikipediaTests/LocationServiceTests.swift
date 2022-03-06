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

    
    func test_performsGETRequestWithURL() {
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
    
    func test_performGETRequestWithURLWithSuccessResponse() {
        let data = anyData()
        let response = anyResponse()
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { _ in
            return (response, data)
        }
        
        makeSUT().getRquest(from: anyURL()) { result in
            switch result {
            case .success(let values):
                XCTAssertEqual(values.data, data)
                XCTAssertEqual(values.response.url, response.url)
                XCTAssertEqual(values.response.statusCode, response.statusCode)
            
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_performGETRequestWithEmptyDataWithSuccessResponse() {
        let data = Data()
        let response = anyResponse()
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { _ in
            return (response, nil)
        }
        
        makeSUT().getRquest(from: anyURL()) { result in
            switch result {
            case .success(let values):
                XCTAssertEqual(values.data, data)
                XCTAssertEqual(values.response.url, response.url)
                XCTAssertEqual(values.response.statusCode, response.statusCode)
            
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
            
            exp.fulfill()
        }
        
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
