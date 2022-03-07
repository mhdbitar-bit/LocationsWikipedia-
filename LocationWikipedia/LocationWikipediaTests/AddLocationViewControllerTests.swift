//
//  AddLocationViewControllerTests.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/7/22.
//

import XCTest
@testable import LocationWikipedia

class AddLocationViewControllerTests: XCTestCase {

    func test_canInit() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.view)
    }
    
    private func makeSUT() -> AddLocationViewController {
        let viewModel = AddLocationViewModel()
        let sut = AddLocationViewController(viewModel: viewModel)
        return sut
    }
}
