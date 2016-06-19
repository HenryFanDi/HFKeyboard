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
  
  private var keyboardRect: CGRect = CGRect()
  
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
  
  private func removeKeyboardObserver() {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  private func addKeyboardObservers() {
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    
    notificationCenter.addObserver(self, selector: "textFieldDidBeginEditing:", name: UITextFieldTextDidBeginEditingNotification, object: nil)
    notificationCenter.addObserver(self, selector: "textFieldDidEndEditing:", name: UITextFieldTextDidEndEditingNotification, object: nil)
    notificationCenter.addObserver(self, selector: "textFieldDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)
    
    notificationCenter.addObserver(self, selector: "textViewDidBeginEditing:", name: UITextViewTextDidBeginEditingNotification, object: nil)
    notificationCenter.addObserver(self, selector: "textViewDidEndEditing:", name: UITextViewTextDidEndEditingNotification, object: nil)
    notificationCenter.addObserver(self, selector: "textViewDidChange:", name: UITextViewTextDidChangeNotification, object: nil)
  }
  
  // MARK: Private
  
  private func viewOffset(keyboardRect: CGRect) {
  }
  
  private func moveOffsetWithKeyboardWillHide() {
  }
  
  // MARK: Keyboard Notification
  
  func keyboardWillShow(aNotification: NSNotification) {
    let keyboardRect = aNotification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
    self.keyboardRect = keyboardRect
    if currentView != nil {
    }
  }
  
  func keyboardWillHide(aNotification: NSNotification) {
    moveOffsetWithKeyboardWillHide()
  }
  
  func keyboardDidHide(aNotification: NSNotification) {
  }
  
  // MARK: TextField Notification
  
  func textFieldDidBeginEditing(aNotification: NSNotification) {
    currentView = aNotification.object as? UIView
  }
  
  func textFieldDidEndEditing(aNotification: NSNotification) {
  }
  
  func textFieldDidChange(aNotification: NSNotification) {
  }
  
  // MARK: TextView Notification
  
  func textViewDidBeginEditing(aNotification: NSNotification) {
  }
  
  func textViewDidEndEditing(aNotification: NSNotification) {
  }
  
  func textViewDidChange(aNotification: NSNotification) {
  }
  
}
