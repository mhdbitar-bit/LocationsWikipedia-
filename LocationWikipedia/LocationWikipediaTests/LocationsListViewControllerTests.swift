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
        let vc = LocationsListViewController(viewModel: viewModel)
        _ = vc.view
            
        XCTAssertNotNil(vc.tableView)
    }
}
