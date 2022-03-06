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
        let sut = makeSUT()

        XCTAssertNotNil(sut.tableView)
    }
    
    func test_viewDidLoad_setTitle() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Locations")
    }
    
    private func makeSUT() -> LocationsListViewController {
        let service = RemoteLocationService(
            url: URL(string: "http://any-url.com")!,
            client: URLSessionHTTPClient(session: .shared))
        let viewModel = LocationViewModel(service: service)
        let sut = LocationsListViewController(viewModel: viewModel)
        
        return sut
    }
}
