//
//  LocationService.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

public protocol LocationService {
    typealias Result = Swift.Result<[Location], Error>
    
    func getLocations(completion: @escaping (Result) -> Void)
}

public final class RemoteLocationService: LocationService {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LocationService.Result
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func getLocations(completion: @escaping (Result) -> Void) {
        client.getRquest(from: url) { result in
            switch result {
            case .success(let (data, response)):
                completion(RemoteLocationService.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let locations = try LocationMapper.map(data, from: response)
            return .success(locations)
        } catch {
            return .failure(error)
        }
    }
}

