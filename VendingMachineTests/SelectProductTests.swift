//
//  SelectProductTests.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import UIKit
import XCTest

class SelectProductTests: XCTestCase {
  var machine = VendingMachine()
  
  override func setUp() {
    super.setUp()
    machine = VendingMachine()  // reinitialize for each test method
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testSelectProductEmptyInventory() {
    XCTAssertEqual(machine.showDisplay(), "INSERT COIN")
    
    var chips = Product(name: "chips", price: 50)
    
    var product = machine.buyProduct(chips)
    XCTAssert(product == nil)

    XCTAssertEqual(machine.showDisplay(), "PRICE 0.50")
    XCTAssertEqual(machine.showDisplay(), "INSERT COIN")
    XCTAssertEqual(machine.showDisplay(), "INSERT COIN")
  }

  func testSelectProductWithInventory() {
    var chips = Product(name: "chips", price: 50)
    var cola = Product(name: "cola", price: 100)
    var candy = Product(name: "candy", price: 65)
    
    machine.addProduct(name: chips.name, price: chips.price)
    machine.addProduct(name: cola.name, price: cola.price)
    machine.addProduct(name: candy.name, price: candy.price)
    
    var coin = machine.insertCoin(weight: 25, size: 25)
    coin = machine.insertCoin(weight: 25, size: 25)

    var product = machine.buyProduct(chips)
    XCTAssert(product != nil)
    
    XCTAssertEqual(machine.showDisplay(), "THANK YOU")
    XCTAssertEqual(machine.showDisplay(), "INSERT COIN")

    // make sure chips are gone
    product = machine.buyProduct(chips)
    XCTAssert(product == nil)
    XCTAssertEqual(machine.showDisplay(), "PRICE 0.50")
    
    
    product = machine.buyProduct(candy)
    XCTAssert(product == nil)
    XCTAssertEqual(machine.showDisplay(), "PRICE 0.65")
    
    coin = machine.insertCoin(weight: 25, size: 25)
    coin = machine.insertCoin(weight: 25, size: 25)
    coin = machine.insertCoin(weight: 10, size: 10)
    coin = machine.insertCoin(weight: 10, size: 10)
    coin = machine.insertCoin(weight: 15, size: 15)
    
    product = machine.buyProduct(candy)
    XCTAssert(product != nil)
    XCTAssertEqual(machine.showDisplay(), "THANK YOU")
    XCTAssertEqual(machine.showDisplay(), "0.10")
    
    var coins = machine.returnCoins()
    XCTAssertEqual(coins.count, 1)
  }
}
