//
//  AcceptCoinsTests.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import Foundation
import XCTest

class AcceptCoinsTests: XCTestCase {
  
  var machine = VendingMachine()

  override func setUp() {
    super.setUp()
    machine = VendingMachine()  // reinitialize for each test method
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testEmptyMachine() {
    XCTAssert(machine.status() == "INSERT COIN", "Empty machine returned wrong message")
  }
  
  func testInsertCoins() {
    
    // invalid coin
    var coin = machine.insertCoin(weight:0, size: 0)
    XCTAssert(coin == nil, "Insert 0 sized coin should fail.")
    
    // dime
    coin = machine.insertCoin(weight: 10, size: 10)
    XCTAssert(coin != nil, "Insert dime should not fail.")
    XCTAssert(coin?.type == .Dime, "Coin type should be dime.")
    XCTAssert(coin?.value == 10.0, "Invalid value for dime.")

    // nickel
    coin = machine.insertCoin(weight: 15, size: 15)
    XCTAssert(coin != nil, "Insert nickel should not fail.")
    XCTAssert(coin?.type == .Nickel, "Coin type should be nickel.")
    XCTAssert(coin?.value == 5.0, "Invalid value for nickel.")
    
    // quarter
    coin = machine.insertCoin(weight: 25, size: 25)
    XCTAssert(coin != nil, "Insert quarter should not fail.")
    XCTAssert(coin?.type == .Quarter, "Coin type should be quarter.")
    XCTAssert(coin?.value == 25.0, "Invalid value for quarter.")
    
    // another invalid coin
    coin = machine.insertCoin(weight:10, size: 15)
    XCTAssert(coin == nil, "Insert weird-sized coin should fail.")
    
    // see what's in the machine
    XCTAssert(machine.currentCoins.count == 3, "Machine should have 3 coints")
    XCTAssert(machine.coinReturn.count == 2, "Machine should have 2 invalid coints")
  }
  

}
