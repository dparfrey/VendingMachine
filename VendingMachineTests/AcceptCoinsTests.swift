//
//  AcceptCoinsTests.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import UIKit
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
    XCTAssertEqual(machine.showDisplay(), "INSERT COIN")
  }
  
  func testInsertCoins() {
    
    // invalid coin
    var coin = machine.insertCoin(weight:0, size: 0)
    XCTAssert(coin == nil)
    
    // dime
    coin = machine.insertCoin(weight: 10, size: 10)
    XCTAssert(coin != nil)
    XCTAssertEqual(coin!.type, CoinType.Dime)
    XCTAssertEqual(coin!.value, 10)

    // nickel
    coin = machine.insertCoin(weight: 15, size: 15)
    XCTAssert(coin != nil)
    XCTAssertEqual(coin!.type, CoinType.Nickel)
    XCTAssertEqual(coin!.value, 5)
    
    // quarter
    coin = machine.insertCoin(weight: 25, size: 25)
    XCTAssert(coin != nil)
    XCTAssertEqual(coin!.type, CoinType.Quarter)
    XCTAssertEqual(coin!.value, 25)
    
    // another invalid coin
    coin = machine.insertCoin(weight:10, size: 15)
    XCTAssert(coin == nil)
    
    // see what's in the machine
    XCTAssert(machine.currentCoins.count == 3)
    XCTAssert(machine.coinReturn.count == 2)
  }
  
}
