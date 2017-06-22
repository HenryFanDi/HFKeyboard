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
  
  fileprivate var _hidden: Bool = false
  var hidden: Bool? {
    get {
      return _hidden
    }
    set(newValue) {
      _hidden = newValue!
      
      if _hidden == true && currentView != nil {
        currentView?.resignFirstResponder()
      }
    }
  }
  
  fileprivate var _enable: Bool = false
  var enable: Bool? {
    get {
      return _enable
    }
    set(newValue) {
      if newValue == _enable {
        return
      }
      _enable = newValue!
      
      if newValue == false {
        removeKeyboardObserver()
        return
      }
      addKeyboardObservers()
    }
  }
  
  fileprivate var moved: Bool = false
  fileprivate var moveOffsetY: CGFloat = 0
  
  fileprivate var _moveView: UIView?
  var moveView: UIView? {
    get {
      return _moveView
    }
    set(newValue) {
      if newValue == nil {
        _moveView = keyWindow()
      } else {
        _moveView = newValue!
      }
      moveViewRect = _moveView!.frame
    }
  }
  
  fileprivate var moveViewRect: CGRect = CGRect()
  fileprivate var keyboardRect: CGRect = CGRect()
  
  // MARK: Singleton Pattern
  
  static let sharedInstance = KeyboardManager()
  
  // MARK: Initialize
  
  override init() {
    super.init()
  }
  
  fileprivate func removeKeyboardObserver() {
    NotificationCenter.default.removeObserver(self)
  }
  
  fileprivate func addKeyboardObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    
    notificationCenter.addObserver(self, selector: #selector(UITextFieldDelegate.textFieldDidBeginEditing(_:)), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UITextFieldDelegate.textFieldDidEndEditing(_:)), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    
    notificationCenter.addObserver(self, selector: #selector(UITextViewDelegate.textViewDidBeginEditing(_:)), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UITextViewDelegate.textViewDidEndEditing(_:)), name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UITextViewDelegate.textViewDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }
  
  // MARK: Private
  
  fileprivate func keyWindow() -> UIWindow {
    let window = UIApplication.shared.keyWindow
    return window!
  }
  
  fileprivate func viewOffset(_ keyboardRect: CGRect) {
    let keyboardMinY = keyboardRect.minY
    
    let currentViewRect = (currentView!.superview?.convert(currentView!.frame, to: keyWindow()))! as CGRect
    let currentViewMaxY = currentViewRect.maxY as CGFloat
    
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
  
  fileprivate func moveOffsetWithKeyboardWillShow(_ offsetY: CGFloat) { // Show
    keyboardWillShowOffset(offsetY)
  }
  
  fileprivate func keyboardWillShowOffset(_ offsetY: CGFloat) {
    let moveView = keyboardOfMoveView()
    
    UIView.animate(withDuration: 0.3, animations: { () -> Void in
      var newFrame = moveView.frame
      newFrame.origin.y = offsetY
      moveView.frame = newFrame
    }) 
  }
  
  fileprivate func moveOffsetWithKeyboardWillHide() { // Hide
    currentView = nil
    moveOffsetY = 0.0
    keyboardWillHideOffset()
  }
  
  fileprivate func keyboardWillHideOffset() {
    let moveView = keyboardOfMoveView()
    
    UIView.animate(withDuration: 0.3, animations: { () -> Void in
      var newFrame = moveView.frame
      newFrame.origin.y = 0.0
      moveView.frame = newFrame
    }) 
  }
  
  fileprivate func keyboardOfMoveView() -> UIView { // View
    var moveView: UIView? = self.moveView
    if moveView == nil {
      moveView = keyWindow()
    }
    return moveView!
  }
  
  // MARK: Keyboard Notification
  
  func keyboardWillShow(_ aNotification: Notification) {
    let keyboardRect = (aNotification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
    self.keyboardRect = keyboardRect!
    if currentView != nil {
      viewOffset(keyboardRect!)
    }
  }
  
  func keyboardWillHide(_ aNotification: Notification) {
    moveOffsetWithKeyboardWillHide()
  }
  
  func keyboardDidHide(_ aNotification: Notification) {
  }
  
  // MARK: TextField Notification
  
  func textFieldDidBeginEditing(_ aNotification: Notification) {
    currentView = aNotification.object as? UIView
  }
  
  func textFieldDidEndEditing(_ aNotification: Notification) {
  }
  
  func textFieldDidChange(_ aNotification: Notification) {
  }
  
  // MARK: TextView Notification
  
  func textViewDidBeginEditing(_ aNotification: Notification) {
  }
  
  func textViewDidEndEditing(_ aNotification: Notification) {
  }
  
  func textViewDidChange(_ aNotification: Notification) {
  }
  
}
