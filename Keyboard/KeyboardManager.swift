//
//  KeyboardManager.swift
//  Keyboard
//
//  Created by HenryFan on 15/6/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class KeyboardManager: NSObject {
  
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
  
}
