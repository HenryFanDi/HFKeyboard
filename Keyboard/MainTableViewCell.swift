//
//  MainTableViewCell.swift
//  Keyboard
//
//  Created by HenryFan on 22/6/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
  @IBOutlet weak var textField: UITextField!
  
  // MARK: Initialize
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: Public
  
  class func nib() -> UINib {
    return UINib(nibName: "MainTableViewCell", bundle: nil)
  }
  
  // MARK: Private
  
  fileprivate func setupMainTableViewCell() {
  }
  
}
