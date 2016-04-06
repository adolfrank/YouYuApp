//
//  MeViewController.swift
//  YouYuApp
//
//  Created by Hongbo Yu on 16/3/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

let offset_ME_HeaderStop:CGFloat = 176 // 背景图片与导航栏的高度差   At this offset the Header stops its transformations
let offset_ME_LabelHeader:CGFloat = 170 // 控制标题出现那刻的Y值   At this offset the Black label reaches the Header
let distance_ME_LabelHeader:CGFloat = 43 // 控制标题最终位置的Y值   The distance between the bottom of the Header and the top of the White Label


import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerLable: UILabel!
    @IBOutlet weak var headerAvater: UIImageView!
    @IBOutlet weak var meTable: UITableView!
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    @IBOutlet weak var AvatarTitle: UILabel!
    
    
    
    @IBAction func avatarBtnDidTouch(sender: AnyObject) {
        // MARK: - 初始化 action sheet
        let optionMenu = UIAlertController(title: nil, message: "修改头像", preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title: "拍照", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
                //MARK: 调用拍照功能
                let picker:UIImagePickerController = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.Camera  // 数据来源
                picker.modalTransitionStyle = UIModalTransitionStyle.CoverVertical  // 取景框出现效果
                picker.allowsEditing = true
                picker.showsCameraControls = true  // 拍照时的工具栏
                picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo  // 初始摄像头模式
                picker.delegate = self
                self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
                self.presentViewController(picker, animated: true, completion: nil)
                picker.view.layoutIfNeeded()
        })
        let saveAction = UIAlertAction(title: "相册", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
                //MARK: 调用相册
                let picker:UIImagePickerController = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.presentViewController(picker, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
     //MARK: 实现调用相册的代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let gotImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        headerAvater.image = gotImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: 相册／拍摄界面的cancel键方法
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meTable.registerClass(MeTableCell.self, forCellReuseIdentifier: "meTableCell")
        // tableview前插入UIView的时候，tableview的autolayout貌似有点问题，所以在此方法中直接指定 Header 的宽度等于屏幕宽度
        header.bounds = CGRectMake(0, 0, self.view.frame.height, 240)
        meTable.bounds = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        // MARK: 设置自定义导航栏的初始化
        headerAvater.image = UIImage(named: "avatar09")
        headerImageView = UIImageView(frame: header.bounds)
        headerImageView?.image = UIImage(named: "Me_ThemeBG")
        headerImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        header.insertSubview(headerImageView, belowSubview: headerLable)
        
        // MARK: 设置导航栏的背景图片 － blur效果等
        headerBlurImageView = UIImageView(frame: header.bounds)
        headerBlurImageView?.image = UIImage(named: "Me_ThemeBG")!.blurredImageWithRadius(6, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView?.alpha = 0
        header.insertSubview(headerBlurImageView, belowSubview: headerLable)
        header.clipsToBounds = true
        
        self.view.bringSubviewToFront(headerAvater)
        self.view.bringSubviewToFront(shareBtn)
    }

    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        if offset <= 0 {
            let headerScaleFactor:CGFloat = -(offset) / (header.bounds.height)
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            header.layer.transform = headerTransform
        }
            // SCROLL UP/DOWN ------------
        else {
            // Header -----------
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_ME_HeaderStop, -offset), 0)
            //  ------------ Label
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_ME_LabelHeader, offset_ME_LabelHeader - offset), 0)
            headerLable.layer.transform = labelTransform
            //  ------------ 导航栏按钮顶置
            let navBtnTrasform = CATransform3DMakeTranslation(0, 0, 10)
//            backBtn.layer.transform = navBtnTrasform
            shareBtn.layer.transform = navBtnTrasform
            //  ------------ 设置导航栏背景的Blur动画
             headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
            // MARK: 头像和名称的透明度变化
            headerAvater.alpha = 1 - offset / offset_ME_LabelHeader
            AvatarTitle.alpha = 1 - offset / offset_ME_LabelHeader
            
            
            // Avatar -----------
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / headerAvater.bounds.height / 6 // Slow down the animation
            let avatarSizeVariation = ((headerAvater.bounds.height * (1.0 + avatarScaleFactor)) - headerAvater.bounds.height) / 20
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            if offset <= offset_HeaderStop  + 20  {
                if headerAvater.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
            }else {
                if headerAvater.layer.zPosition >= header.layer.zPosition  {
                    header.layer.zPosition = 2
                }
            }
        }
        // Apply Transformations
        header.layer.transform = headerTransform
        headerAvater.layer.transform = avatarTransform
    }
    

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeTableData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = meTable.dequeueReusableCellWithIdentifier("meTableCell", forIndexPath: indexPath)
        cell.textLabel?.text = MeTableData[indexPath.row].meTitle
        cell.imageView?.image = UIImage(named: MeTableData[indexPath.row].icon)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        meTable.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
