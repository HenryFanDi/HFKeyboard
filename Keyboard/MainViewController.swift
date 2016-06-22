//
//  MainViewController.swift
//  Keyboard
//
//  Created by HenryFan on 14/6/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private let MainCellReuseIdentifier = "MainCellReuseIdentifier"
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Lifecycle
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    KeyboardManager.shared.enable = true
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    KeyboardManager.shared.enable = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainViewController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  private func setupMainViewController() {
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.registerNib(MainTableViewCell.nib(), forCellReuseIdentifier: MainCellReuseIdentifier)
    
    tableView.estimatedRowHeight = 50.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  // MARK: UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let tableViewCell = tableView.dequeueReusableCellWithIdentifier(MainCellReuseIdentifier) as! MainTableViewCell
    tableViewCell.backgroundColor = UIColor.redColor()
    return tableViewCell
  }
  
  // MARK: UITableViewDelegate
  
}
