//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import Foundation

class VendingMachine {
  var validCoins:[Coin] = []
  var currentCoins:[Coin] = []
  var coinReturn:[Coin] = []
  
  init() {
    validCoins.append(Coin(type:.Dime, value:10, weight:10, size:10))
    validCoins.append(Coin(type:.Nickel, value:5, weight:15, size:15))
    validCoins.append(Coin(type:.Quarter, value:25, weight:25, size:25))
  }
  
  func status() -> String {
    if currentCoins.count > 0 {
      return "TODO"
    }
    
    return "INSERT COIN"
  }
  
  func insertCoin(#weight:Int, size:Int) -> Coin? {
    
    if let newCoin = validateCoin(weight:weight, size:size) {
      currentCoins.append(newCoin)
      return newCoin
    }
  
    coinReturn.append(Coin(type: .Invalid, value: 0, weight: weight, size: size))
    
    return nil
  }

  func validateCoin(#weight:Int, size:Int) -> Coin? {

    for coin in validCoins {
      if coin.weight == weight && coin.size == size {
        return coin
      }
    }
    
    return nil
  }
}