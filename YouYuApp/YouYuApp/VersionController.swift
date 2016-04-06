//
//  VersionController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/29/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class VersionController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var versionLable: UILabel!
    @IBOutlet weak var versionTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = UINib(nibName: "AboutCell", bundle: nil)
        versionTable.registerNib(cell, forCellReuseIdentifier: "aboutCell")
        
        let infoDic = NSBundle.mainBundle().infoDictionary
        // 获取App的版本号
        let appVersion = infoDic?["CFBundleShortVersionString"] as! String
        // 获取App的build版本
        let appBuildVersion = infoDic?["CFBundleVersion"] as! String
        
        versionLable.text = "Version" + " " + appVersion + "  " + "Build" + " " + appBuildVersion
    }

    
    
    override func viewWillAppear(animated: Bool) {
        setBackButtonWithImage()
    }
    
    
    
    func setBackButtonWithImage()  {
        self.title = "关于有渔"
        let backImg: UIImage = UIImage(named: "backBtn")!
        let leftBtn: UIBarButtonItem = UIBarButtonItem(image: backImg, style: .Done, target: self, action:#selector(SettingViewController.goToBack))
        self.navigationItem.leftBarButtonItem = leftBtn
    }
    
    func goToBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = versionTable.dequeueReusableCellWithIdentifier("aboutCell", forIndexPath: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "评分"}
        else if indexPath.row == 1 {
            cell.textLabel?.text = "网站"}
        else {
            cell.textLabel?.text = "功能"}
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        versionTable.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
