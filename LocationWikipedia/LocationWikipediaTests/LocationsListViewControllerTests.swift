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
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.tableView)
    }
    
    func test_viewDidLoad_setTitle() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.title, "Locations")
    }
    
    func test_configureTableView() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.tableView.delegate, "Expeted TableViewDelegate to be not nil")
        XCTAssertNotNil(sut.tableView.dataSource, "Expeted TableViewDataSrouce to be not nil")
    }
    
    func test_viewDidLoad_initialState() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
        
    private func makeSUT() -> LocationsListViewController {
        let service = RemoteLocationService(
            url: anyURL(),
            client: URLSessionHTTPClient(session: .shared))
        let viewModel = LocationViewModel(service: service)
        let sut = LocationsListViewController(viewModel: viewModel)
        
        return sut
    }
}
