//
//  KeyboardManager.swift
//  Keyboard
//
//  Created by HenryFan on 15/6/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class KeyboardManager: NSObject {
  
  var currentView: UIView?
  
  private var hidden: Bool? {
    get {
      return self.hidden
    }
    set(newValue) {
      self.hidden = newValue
    }
  }
  
  private var enable: Bool? {
    get {
      return self.enable
    }
    set(newValue) {
      self.enable = newValue
    }
  }
  
  private var moved: Bool = false
  private var moveOffsetY: CGFloat = 0
  
  private var moveView: UIView? {
    get {
      return self.moveView
    }
    set(newValue) {
      if newValue == nil {
        self.moveView = UIView.init(frame: UIScreen.mainScreen().bounds)
      } else {
        self.moveView = newValue
      }
    }
  }
  
  // MARK: Singleton Pattern
  
  class var shared: KeyboardManager {
    struct Static {
      static var instance: KeyboardManager?
      static var token: dispatch_once_t = 0
    }
    dispatch_once(&Static.token) {
      Static.instance = KeyboardManager()
    }
    return Static.instance!
  }
  
  // MARK: Initialize
  
  override init() {
    super.init()
  }
  
}
