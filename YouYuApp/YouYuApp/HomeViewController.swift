//
//  HomeViewController.swift
//  11-day
//
//  Created by Hongbo Yu on 16/3/24.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

struct video {
    let image: String
    let title: String
    let subTitle: String
    let source: String
    let avatar: String
}


class HomeViewController: UITableViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cellHeaderLable: UILabel!
    @IBOutlet var HomeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
 
    
    // MARK: - 添加滑动返回手势，别忘了加上 UIGestureRecognizerDelegate 代理方法
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func viewDidTouch(sender: AnyObject) {
        searchBar.resignFirstResponder()
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
        
        HomeTable.setContentOffset(CGPointMake(0, 44), animated: true)
    }
    
    


    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
   
    
    
   
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HomeTable.dequeueReusableCellWithIdentifier("homecell", forIndexPath: indexPath) as! HomeTableCell
        let cellInfo = data[indexPath.row]
        cell.titleImage.image = UIImage(named: cellInfo.image)
        cell.titleLable.text = cellInfo.title
        return cell
    }
    
    
    
    // MARK: - 设置表格的表头样式，可通过storyboard连线的方式自定义，同tableviewcell一样
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeTable.dequeueReusableCellWithIdentifier("homecellheader") as! HomeTableHeader
        // MARK: 按钮属性的赋值要用set方法
        header.homeHeaderTitle.setTitle(headerData[section].title, forState: UIControlState.Normal)
        header.homeHeaderTitle.setImage(UIImage(named: headerData[section].avatar), forState: UIControlState.Normal)
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    // MARK: - 设置表格的表尾样式，可通过storyboard连线的方式自定义，同tableviewcell一样
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = HomeTable.dequeueReusableCellWithIdentifier("homecellfooter") as! HomeTableFooter
//        return footer
//    }
    
    
    
    // MARK: - 在此方法中设置要通过push传递的数据，并在目标控制器中设置对应的变量接受此方法中传递的数据
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        searchBar.resignFirstResponder()
        if segue.identifier == "ProfileSegue" {
            let toView = segue.destinationViewController as! ProfileViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            toView.textToGo = data[indexPath.row].title
            toView.imageToGo = data[indexPath.row].image
            toView.avatarToGo = data[indexPath.row].avatar
        }
    }
    
    
    
}
