//
//  DisplayScreen.swift
//  VendingMachine
//
//  Created by Dave Parfrey on 5/26/15.
//  Copyright (c) 2015 Brains for Business, Inc. All rights reserved.
//

import Foundation

class DisplayScreen {
  var stack:[String]

  let emptyAmount = "INSERT COIN"
  
  init() {
    stack = [emptyAmount]
  }
  
  // sets a message, clearing everything on the stack
  func set(message:String) {
    clear()
    push(message)
  }

  // set two messages. Really, that's all we need
  func set(#firstMessage:String, secondMessage:String) {
    clear()
    push(secondMessage)
    push(firstMessage)
  }
  
  // reset the display to its initial state
  func reset() {
    clear()
    push(emptyAmount)
  }
  
  // push one or more messages on the stack
  func push(message:String) {
    stack.append(message)
  }
  
  // pop a message off the stack
  func pop() -> String {
    if stack.count > 0 {
      let message = stack.removeAtIndex(stack.count - 1)
      return message
    }
  
    return ""
  }
  
  func show() -> String {
    if stack.count > 1 {
      return pop()
    } else if stack.count == 1 {
      return stack[0] // don't pop
    }
    
    return ""
  }
  
  func clear() {
    stack.removeAll(keepCapacity: true)
  }
}