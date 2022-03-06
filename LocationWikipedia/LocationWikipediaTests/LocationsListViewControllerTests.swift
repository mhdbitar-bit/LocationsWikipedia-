//
//  LocationWikipediaTests.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/3/22.
//

import XCTest
@testable import LocationWikipedia

class LocationsListViewControllerTests: XCTestCase {

    func test_canInit() {
        let service = RemoteLocationService(
            url: URL(string: "http://any-url.com")!,
            client: URLSessionHTTPClient(session: .shared))
        let viewModel = LocationViewModel(service: service)
        let sut = LocationsListViewController(viewModel: viewModel)
        _ = sut.view
            
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_viewDidLoad_setTitle() {
        let service = RemoteLocationService(
            url: URL(string: "http://any-url.com")!,
            client: URLSessionHTTPClient(session: .shared))
        let viewModel = LocationViewModel(service: service)
        let sut = LocationsListViewController(viewModel: viewModel)
        _ = sut.view

        XCTAssertEqual(sut.title, "Locations")
    }
}
