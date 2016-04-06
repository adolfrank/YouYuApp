//
//  CenterTableController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/27/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class CenterTableController: UITableViewController {
    
    let height:CGFloat = UIScreen.mainScreen().bounds.height
    let width:CGFloat = UIScreen.mainScreen().bounds.width
    @IBOutlet var centerTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerTableView.frame = CGRectMake(0, 0, width, height)
        centerTableView.contentInset = UIEdgeInsetsMake(18, 0, 88, 0)
        let cellCenter = UINib(nibName: "CenterTableCell", bundle: nil)
        self.centerTableView.registerNib(cellCenter, forCellReuseIdentifier: "CenterTableCell")
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellCenter = centerTableView.dequeueReusableCellWithIdentifier("CenterTableCell", forIndexPath: indexPath)
        return cellCenter
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        centerTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
