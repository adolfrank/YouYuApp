//
//  SettingViewController.swift
//  YouYuApp
//
//  Created by Hongbo Yu on 16/3/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UIGestureRecognizerDelegate, UITableViewDataSource,UITableViewDelegate {

     var settingTableData: NSArray?
    @IBOutlet weak var settingTableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       settingTableView.registerClass(settingTableCell.self, forCellReuseIdentifier: "settingTableCell")
        settingTableView.delegate = self
        settingTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let filepath = NSBundle.mainBundle().pathForResource("SettingData.plist", ofType: nil)
        settingTableData = NSArray(contentsOfFile: filepath!)
        
        print(settingTableData?.count)

    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setBackButtonWithImage()
    }
    

    func setBackButtonWithImage()  {
        self.title = "设置"
        let backImg: UIImage = UIImage(named: "backBtn")!
        let leftBtn: UIBarButtonItem = UIBarButtonItem(image: backImg, style: .Done, target: self, action:#selector(SettingViewController.goToBack))
        self.navigationItem.leftBarButtonItem = leftBtn
         self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    func goToBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settingTableData!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTableData![section]["sectionData"]!!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return settingTableData![section]["headerTitle"] as? String
        } else {
            return ""
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCellWithIdentifier("settingTableCell", forIndexPath: indexPath) as! settingTableCell
        if indexPath.section == 2 {
            cell.imageView?.image = UIImage(named:  ((settingTableData![indexPath.section]["sectionData"]!![indexPath.row]["image"] as? String))!)
        } else {
            cell.imageView?.hidden = true
        }
        cell.textLabel?.text =  settingTableData![indexPath.section]["sectionData"]!![indexPath.row]["title"] as? String
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 3 && indexPath.row == 0) {
                let toView:VersionController = VersionController()
                self.navigationController?.pushViewController(toView, animated: true)
                settingTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        settingTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
