//
//  ProfileViewController.swift
//  11-day
//
//  Created by Hongbo Yu on 16/3/24.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

/*
 这三个值调节动画效果
 在storyboard中，先指定各控件的位置，再在这里调节数值
 */
let offset_HeaderStop:CGFloat = 136 // 背景图片与导航栏的高度差   At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 165 // 控制标题出现那刻的Y值   At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 43 // 控制标题最终位置的Y值   The distance between the bottom of the Header and the top of the White Label


class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var textToGo:String = ""
    var imageToGo: String = ""
    var avatarToGo: String = ""
    var plistToGo :String = ""
    var prototypeCell: ProfileTableCell!
    var profileTableData: NSArray?
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var Header: UIView!
    @IBOutlet weak var HeaderLable: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var ProfileTable: UITableView!
    @IBOutlet weak var AvatarLable: UILabel!
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    
    
    
    // MARK: - 设置自定义导航栏
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // MARK: 设置代理和数据源
        ProfileTable.delegate = self
        ProfileTable.dataSource = self
        
        // MARK: 设置自定义导航栏的初始化
        AvatarLable.text = textToGo
        HeaderLable.text = textToGo
        AvatarImage.image = UIImage(named: avatarToGo)
        headerImageView = UIImageView(frame: Header.bounds)
        headerImageView.image = UIImage(named: imageToGo)
        headerImageView.contentMode = UIViewContentMode.ScaleAspectFill
        // MARK: tableview前插入UIView的时候，tableview的autolayout貌似有点问题，所以在此方法中直接指定 Header 的宽度等于屏幕宽度
        Header.bounds = CGRectMake(0, 0, self.view.frame.height, 200)
        ProfileTable.bounds = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        Header.insertSubview(headerImageView, belowSubview: HeaderLable)
        
        // MARK: 设置导航栏的背景图片 － blur效果等
        headerBlurImageView = UIImageView(frame: Header.bounds)
        headerBlurImageView?.image = UIImage(named: imageToGo)?.blurredImageWithRadius(3, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView?.alpha = 1
        Header.insertSubview(headerBlurImageView, belowSubview: HeaderLable)
        Header.clipsToBounds = true
        
        // MARK: 设置导航栏按钮 － 顶置图层
        self.view.bringSubviewToFront(backBtn)
        self.view.bringSubviewToFront(shareBtn)
        
        let filepath = NSBundle.mainBundle().pathForResource(plistToGo, ofType: "plist")
        profileTableData = NSArray(contentsOfFile: filepath!)

        //MARK: 设置tableview的行高:可根据文字高度自动调节高度
        ProfileTable.estimatedRowHeight = 140
        ProfileTable.rowHeight = UITableViewAutomaticDimension
        }

    
    @IBAction func backBtnDidTouch(sender: AnyObject) {
        // MARK: 此方法回到push过来的上一级
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - 此方法中定义了导航栏的关键动画效果
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        if offset <= 0 {
            let headerScaleFactor:CGFloat = -(offset) / Header.bounds.height
            let headerSizevariation = ((Header.bounds.height * (1.0 + headerScaleFactor)) - Header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            Header.layer.transform = headerTransform
        }
            // SCROLL UP/DOWN ------------
        else {
            // Header -----------
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            //  ------------ Label
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            HeaderLable.layer.transform = labelTransform
            //  ------------ 导航栏按钮顶置
            let navBtnTrasform = CATransform3DMakeTranslation(0, 0, 10)
            backBtn.layer.transform = navBtnTrasform
            shareBtn.layer.transform = navBtnTrasform
            //  ------------ 设置导航栏背景的Blur动画
           // headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            // Avatar -----------
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / AvatarImage.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((AvatarImage.bounds.height * (1.0 + avatarScaleFactor)) - AvatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            if offset <= offset_HeaderStop {
                if AvatarImage.layer.zPosition < Header.layer.zPosition{
                    Header.layer.zPosition = 0
                }
            }else {
                if AvatarImage.layer.zPosition >= Header.layer.zPosition{
                    Header.layer.zPosition = 2
                }
            }
        }
        // Apply Transformations
        Header.layer.transform = headerTransform
        AvatarImage.layer.transform = avatarTransform
    }
    

    
    // MARK: - 此方法中隐藏系统自带的导航栏，因为此方法会在每次push进来的时候加载
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    

    
    // MARK: - 设置表格的行数／列数／每行的数据
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (profileTableData?.count)!
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ProfileTable.dequeueReusableCellWithIdentifier("profilecell", forIndexPath: indexPath) as! ProfileTableCell
        cell.profileCellItem.text = profileTableData![indexPath.row]["title"] as? String
        cell.profileCellItem.numberOfLines = 0
        cell.profileCellItem.sizeToFit()
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ProfileTable.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WebViewSegue" {
            let toView = segue.destinationViewController as! WebController
            let indexPath = ProfileTable.indexPathForCell(sender as! UITableViewCell)!
            toView.titleToGo =  (profileTableData![indexPath.row]["title"] as? String)!
            toView.urlToGo =  (profileTableData![indexPath.row]["url"] as? String)!
          }
    }
   
    
    @IBAction func shareBtnDidTouch(sender: AnyObject) {
        let activityViewController = UIActivityViewController(
            activityItems: [HeaderLable.text! as String],
            applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
