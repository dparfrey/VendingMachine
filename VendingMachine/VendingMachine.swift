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
  
  var currentProducts:[Product] = []
  
  var displayScreen = DisplayScreen()
  
  init() {
    validCoins.append(Coin(type:.Dime, value:10, weight:10, size:10))
    validCoins.append(Coin(type:.Nickel, value:5, weight:15, size:15))
    validCoins.append(Coin(type:.Quarter, value:25, weight:25, size:25))
    
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
  
  // calculate the current coin value
  func currentCoinValue() -> Int {
    var amount:Int = 0
    
    for coin in currentCoins {
      amount += coin.value
    }
    return amount
  }
  
  // add a product to the machine
  func addProduct(#name:String, price:Int) -> Product {
    let product = Product(name: name, price: price)
    
    currentProducts.append(product)
    
    return product
  }
  
  // attempt to buy a product
  func buyProduct(product:Product) -> Product? {
    
    for (index, prod) in enumerate(currentProducts) {
      if prod.name == product.name && prod.price == product.price {
        // match! Do we have enough money?
        if currentCoinValue() >= prod.price {
          if saveCoins(currentCoinValue() - prod.price) {
            displayScreen.set(firstMessage: "THANK YOU", secondMessage: getCoinAmountForDisplay())
            return currentProducts.removeAtIndex(index)
          } else {
            
          }
        } else {
          displayScreen.set(firstMessage: getPriceForDisplay(prod.price), secondMessage: getCoinAmountForDisplay())
        }
        return nil
      }
    }
    
    displayScreen.set(firstMessage: getPriceForDisplay(product.price), secondMessage: getCoinAmountForDisplay())
    return nil  // product not found
  }
  
  // MARK: - Display screen methods
  func showDisplay() -> String {
    return displayScreen.show()
  }
  
  func getCoinAmountForDisplay() -> String {
    let amount = currentCoinValue()
    
    return amount == 0 ? displayScreen.emptyAmount : "\(formattedAmount(amount))"
  }
  
  func getPriceForDisplay(price:Int) -> String {
    
    return "PRICE \(formattedAmount(price))"
  }

  // format an amount
  func formattedAmount(amount:Int) -> String {
    return String(format: "%0.2f", Double(amount)/100.0)
  }
  
  // HACK ALERT:
  // I'm going to simplify things in this: assume that there's either 5, 10, or
  // 15 cents to be returned, which is true, assuming they didn't throw extra
  // money in the machine. Also, I'm not going to have a "coin box" with all the 
  // extra money from previous people.
  func saveCoins(amount:Int) -> Bool {
    var savedCoinArray:[Coin] = []
    
    var amountLeft = amount
    
    if amountLeft >= 10 {
      // look for a dime
      for (index, coin) in enumerate(currentCoins) {
        if coin.value == 10 {
          savedCoinArray.append(coin)
          amountLeft -= 10
          break
        }
      }
    }
    
    if amountLeft > 0 {
      // looking for nickels
      for (index, coin) in enumerate(currentCoins) {
        if coin.value == 5 {
          savedCoinArray.append(coin)
          amountLeft -= 5
          if amountLeft == 0 {
            break
          }
        }
      }
    }
    
    if amountLeft == 0 {
      currentCoins.removeAll(keepCapacity: true)
      currentCoins = savedCoinArray
      return true
    }
    
    return false  // failure
  }
  
  func returnCoins() -> [Coin] {
    let coins = currentCoins
    
    currentCoins.removeAll(keepCapacity: true)
    return coins
  }
  
}