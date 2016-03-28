//
//  LeftTableController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/27/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class LeftTableController: UITableViewController {
 
    let height:CGFloat = UIScreen.mainScreen().bounds.height
    let width:CGFloat = UIScreen.mainScreen().bounds.width
    
    @IBOutlet var leftTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTableView.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        
        let cell = UINib(nibName: "LeftTableCell", bundle: nil)
        
        self.leftTableView.registerNib(cell, forCellReuseIdentifier: "LeftTableCell")
    }

    override func viewWillAppear(animated: Bool) {
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LeftBannerData.count
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = leftTableView.dequeueReusableCellWithIdentifier("LeftTableCell", forIndexPath: indexPath) as! LeftTableCell
        cell.banner.image = UIImage(named: LeftBannerData[indexPath.row].banner)
        cell.title.text = LeftBannerData[indexPath.row].title
        cell.subTitle.text = LeftBannerData[indexPath.row].subtitle
        return cell
    }
 
    
   
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("scrollViewDidScroll - 发现栏")
        let vc = ArticalViewController()
        presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    
    
}
