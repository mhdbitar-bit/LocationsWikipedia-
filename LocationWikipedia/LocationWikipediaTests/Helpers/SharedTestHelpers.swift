//
//  SharedTestHelpers.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/6/22.
//

import Foundation
import LocationWikipedia

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyNSError() -> NSError {
    return NSError(domain: "", code: 0)
}

func anyResponse() -> HTTPURLResponse {
    return HTTPURLResponse(statusCode: 200)
}

func makeJson(_ locations: [[String: Any]]) -> Data {
    let json = ["locations": locations]
    return try! JSONSerialization.data(withJSONObject: json)
}

func makelocation(name: String, lat: Double, long: Double) -> (model: Location, json: [String: Any]) {
    let location = Location(name: name, coordinators: (latitude: lat, longitude: long))
    
    let json = [
        "name": name,
        "lat": lat,
        "long": long
    ].compactMapValues { $0 }
    
    return (location, json)
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
