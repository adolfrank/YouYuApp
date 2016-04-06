//
//  HomeViewController.swift
//  11-day
//
//  Created by Hongbo Yu on 16/3/24.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit



class HomeViewController: UITableViewController,UIGestureRecognizerDelegate {

    
    var homeTableData: NSArray?
    @IBOutlet weak var cellHeaderLable: UILabel!
    @IBOutlet var HomeTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        let filepath = NSBundle.mainBundle().pathForResource("HomeTableData.plist", ofType: nil)
        homeTableData = NSArray(contentsOfFile: filepath!)
    }

 
    @IBAction func searchBtnDidTouch(sender: AnyObject) {
        let toView = SearchViewController(nibName: "SearchViewController", bundle: nil )
        toView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toView, animated: true)
    }
    

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
   
   
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (homeTableData?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeTableData![section]["sectionData"]!!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HomeTable.dequeueReusableCellWithIdentifier("homecell", forIndexPath: indexPath) as! HomeTableCell
        cell.titleImage.image = UIImage(named: (homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["image"] as? String)!)
        cell.titleLable.text = homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["title"] as? String
        cell.subTitleLable.text = homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["subTitle"] as? String
        return cell
    }
    
    
    
    // MARK: - 设置表格的表头样式，可通过storyboard连线的方式自定义，同tableviewcell一样
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeTable.dequeueReusableCellWithIdentifier("homecellheader") as! HomeTableHeader
        header.headerAvatar.image = UIImage(named: (homeTableData![section]["headerAvatar"] as? String)!)
        header.hearderTitle.text = homeTableData![section]["headerTitle"] as? String
        header.headerTag.text = homeTableData![section]["headerTag"] as? String
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 340
    }
    
    
    // MARK: - 在此方法中设置要通过push传递的数据，并在目标控制器中设置对应的变量接受此方法中传递的数据
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfileSegue" {
            let toView = segue.destinationViewController as! ProfileViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            toView.textToGo =  (homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["title"] as? String)!
            toView.imageToGo = (homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["image"] as? String)!
            toView.avatarToGo = (homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["avatar"] as? String)!
            toView.plistToGo = (homeTableData![indexPath.section]["sectionData"]!![indexPath.row]["plistToGo"] as? String)!
        }
    }
    
    // MARK: - 添加滑动返回手势，别忘了加上 UIGestureRecognizerDelegate 代理方法
    //    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    //        return true
    //    }

    
    //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 30
    //    }
    
    // MARK: - 设置表格的表尾样式，可通过storyboard连线的方式自定义，同tableviewcell一样
    //    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let footer = HomeTable.dequeueReusableCellWithIdentifier("homecellfooter") as! HomeTableFooter
    //        footer.backgroundColor = UIColor.clearColor()
    //        return footer
    //    }
    
}
