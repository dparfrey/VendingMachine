//
//  DisplayScreenTests.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import UIKit
import XCTest

class DisplayScreenTests: XCTestCase {
  
  var screen = DisplayScreen()
  
  override func setUp() {
    super.setUp()
    screen = DisplayScreen()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testInitialState() {
    XCTAssertEqual(screen.show(), screen.emptyAmount)
  }
  
  func testSet() {
    screen.set("test message")
    XCTAssertEqual(screen.show(), "test message")
    
    // make sure it hasn't been popped
    XCTAssertEqual(screen.show(), "test message")
  }
 
  func testSet2() {
    screen.set(firstMessage: "message 1", secondMessage: "message 2")
    
    XCTAssertEqual(screen.show(), "message 1")  // should pop
    XCTAssertEqual(screen.show(), "message 2")  // won't pop
    XCTAssertEqual(screen.show(), "message 2")  // still there
    
    screen.clear()
    XCTAssertEqual(screen.show(), "")  // gone!
  }
  
  func testReset() {
    screen.set(firstMessage: "message 1", secondMessage: "message 2")

    screen.reset()
    XCTAssertEqual(screen.show(), screen.emptyAmount)
  }
}
