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
}
