//
//  Endpoint.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/3/22.
//

import Foundation

protocol Endpoint {
    var shceme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
