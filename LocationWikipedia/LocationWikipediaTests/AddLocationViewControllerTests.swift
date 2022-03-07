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
    
    func test_displayingTitle() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Add Location")
    }
    
    func test_addButtonHasActionAssigned() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        let addButton: UIButton = sut.addButton
        XCTAssertNotNil(addButton, "'AddLocationViewController' does not have UIButton property")
        
        guard let addButtonActions = addButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
        
        XCTAssertTrue(addButtonActions.contains("addBtnTapped:"))
    }
    
    private func makeSUT() -> AddLocationViewController {
        let viewModel = AddLocationViewModel()
        let sut = AddLocationViewController(viewModel: viewModel)
        return sut
    }
}
