//
//  KeyboardManager.swift
//  Keyboard
//
//  Created by HenryFan on 15/6/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

var OBJECT_OFFSET: CGFloat { get { return 10.0 } }

class KeyboardManager: NSObject {
  
  var currentView: UIView?
  
  private var hidden: Bool? {
    get {
      return self.hidden
    }
    set(newValue) {
      self.hidden = newValue
      
      if self.hidden == true && currentView != nil {
        currentView?.resignFirstResponder()
      }
    }
  }
  
  private var enable: Bool? {
    get {
      return self.enable
    }
    set(newValue) {
      if newValue == self.enable {
        return
      }
      self.enable = newValue
      
      if newValue == false {
        removeKeyboardObserver()
        return
      }
      addKeyboardObservers()
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
        self.moveView = keyWindow()
      } else {
        self.moveView = newValue
      }
      moveViewRect = self.moveView!.frame
    }
  }
  
  private var moveViewRect: CGRect = CGRect()
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
  
  private func keyWindow() -> UIWindow {
    let window = UIApplication.sharedApplication().keyWindow
    return window!
  }
  
  private func viewOffset(keyboardRect: CGRect) {
    let keyboardMinY = CGRectGetMinY(keyboardRect)
    
    let currentViewRect = (currentView!.superview?.convertRect(currentView!.frame, toView: keyWindow()))! as CGRect
    let currentViewMaxY = CGRectGetMaxY(currentViewRect) as CGFloat
    
    if currentViewMaxY > keyboardMinY {
      moved = true
      moveOffsetY = currentViewMaxY - keyboardMinY
      moveOffsetWithKeyboardWillShow(-moveOffsetY - OBJECT_OFFSET)
    } else {
      if (moved) { // Is moved, hide the keyboard
        moved = false
        keyboardWillHideOffset()
      }
    }
  }
  
  private func moveOffsetWithKeyboardWillShow(offsetY: CGFloat) { // Show
    keyboardWillShowOffset(offsetY)
  }
  
  private func keyboardWillShowOffset(offsetY: CGFloat) {
    let moveView = keyboardOfMoveView()
    
    UIView.animateWithDuration(0.3) { () -> Void in
      var newFrame = moveView.frame
      newFrame.origin.y = offsetY
      moveView.frame = newFrame
    }
  }
  
  private func moveOffsetWithKeyboardWillHide() { // Hide
    currentView = nil
    moveOffsetY = 0.0
    keyboardWillHideOffset()
  }
  
  private func keyboardWillHideOffset() {
    let moveView = keyboardOfMoveView()
    
    unowned let unownedSelf = self
    UIView.animateWithDuration(0.3) { () -> Void in
      moveView.frame = unownedSelf.moveViewRect
    }
  }
  
  private func keyboardOfMoveView() -> UIView { // View
    var moveView: UIView? = self.moveView
    if moveView == nil {
      moveView = keyWindow()
    }
    return moveView!
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
