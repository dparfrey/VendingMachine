//
//  Coin.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import Foundation

enum CoinType {
  case Dime
  case Nickel
  case Quarter
  case Invalid
}

class Coin {
  let type:CoinType
  let value:Double
  let weight:Int        // use a dummy int value for this exercise
  let size: Int         // same as weight, just a dummy value
  
  init(type:CoinType, value:Double, weight:Int, size:Int) {
    self.type = type
    self.value = value
    self.weight = weight
    self.size = size
  }
}