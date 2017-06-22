//
//  MainViewController.swift
//  Keyboard
//
//  Created by HenryFan on 14/6/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  fileprivate let MainCellReuseIdentifier = "MainCellReuseIdentifier"
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Lifecycle
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    KeyboardManager.sharedInstance.enable = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    KeyboardManager.sharedInstance.enable = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainViewController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  fileprivate func setupMainViewController() {
    setupTableView()
  }
  
  fileprivate func setupTableView() {
    tableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainCellReuseIdentifier)
    
    tableView.estimatedRowHeight = 50.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  // MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tableViewCell = tableView.dequeueReusableCell(withIdentifier: MainCellReuseIdentifier) as! MainTableViewCell
    tableViewCell.backgroundColor = UIColor.red
    return tableViewCell
  }
  
  // MARK: UITableViewDelegate
  
}
