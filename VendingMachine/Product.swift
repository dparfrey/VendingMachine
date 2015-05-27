//
//  Product.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import Foundation

class Product {
  let name:String
  let price:Int
  
  init(name:String, price:Int) {
    self.name = name
    self.price = price
  }
}