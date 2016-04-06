//
//  RightTableController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/27/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class RightTableController: UITableViewController {
    
    
    let height:CGFloat = UIScreen.mainScreen().bounds.height
    let width:CGFloat = UIScreen.mainScreen().bounds.width
    @IBOutlet var rightTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightTableView.frame = CGRectMake(0, 0, width, height)
        rightTableView.contentInset = UIEdgeInsetsMake(18, 0, 88, 0)
        let cellRight = UINib(nibName: "RightTableCell", bundle: nil)
        self.rightTableView.registerNib(cellRight, forCellReuseIdentifier: "RightTableCell")
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellRight = rightTableView.dequeueReusableCellWithIdentifier("RightTableCell", forIndexPath: indexPath)
        return cellRight
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        rightTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
