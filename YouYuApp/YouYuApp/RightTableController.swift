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
        rightTableView.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        let cellRight = UINib(nibName: "RightTableCell", bundle: nil)
        
        self.rightTableView.registerNib(cellRight, forCellReuseIdentifier: "RightTableCell")
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellRight = rightTableView.dequeueReusableCellWithIdentifier("RightTableCell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        return cellRight
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("选中啦tableView")
    }
}
