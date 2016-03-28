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
        centerTableView.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        let cellCenter = UINib(nibName: "CenterTableCell", bundle: nil)
        
        self.centerTableView.registerNib(cellCenter, forCellReuseIdentifier: "CenterTableCell")
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellCenter = centerTableView.dequeueReusableCellWithIdentifier("CenterTableCell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        return cellCenter
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("选中啦tableView")
    }
    
}
