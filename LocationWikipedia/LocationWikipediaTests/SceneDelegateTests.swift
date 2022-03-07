//
//  SceneDelegateTests.swift
//  LocationWikipediaTests
//
//  Created by Mohammad Bitar on 3/7/22.
//

import XCTest
@testable import LocationWikipedia

private class UIWindowSpy: UIWindow {
  var makeKeyAndVisibleCallCount = 0
  
  override func makeKeyAndVisible() {
    makeKeyAndVisibleCallCount = 1
  }
}

class SceneDelegateTests: XCTestCase {
    
    func test_configureWindow_setsWindowAsKeyAndVisible() {
        let window = UIWindowSpy()
        let sut = SceneDelegate()
        sut.window = window
        
        sut.configureWindow()
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1)
    }
    
    func test_configureWindow_configuresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindowSpy()
        
        sut.configureWindow()
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a navigation controller as root, got \(String(describing: root)) instead")
        XCTAssertTrue(topController is LocationsListViewController, "Expected a feed controller as top view controller, got \(String(describing: topController)) instead")
    }
}
