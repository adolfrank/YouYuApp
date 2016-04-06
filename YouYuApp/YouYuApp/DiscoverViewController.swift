//
//  DiscoverViewController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/27/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController,UIScrollViewDelegate, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var discoverScrollView: UIScrollView!
    @IBOutlet weak var titleView: UIView!
    
    let height:CGFloat = UIScreen.mainScreen().bounds.height
    let width:CGFloat = UIScreen.mainScreen().bounds.width
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        scrollViewDidEndScrollingAnimation(discoverScrollView)
       // self.automaticallyAdjustsScrollViewInsets = false  禁止自动调整scrollview的inset
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupVC() {
        let leftVC:LeftTableController = LeftTableController()
        let centerVC:CenterTableController = CenterTableController()
        let rightVC:RightTableController = RightTableController()
        discoverScrollView.contentSize = CGSizeMake(width * 3, 0)
        discoverScrollView.delegate = self
        discoverScrollView.bounces = true
        self.addChildViewController(leftVC)
        self.addChildViewController(centerVC)
        self.addChildViewController(rightVC)
    }

    
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
               let scale: CGFloat  = discoverScrollView.contentOffset.x / discoverScrollView.frame.size.width
        let leftBtn =  self.titleView.subviews[0] as! UIButton
        let centerBtn =  self.titleView.subviews[1] as! UIButton
        let rghtBtn =  self.titleView.subviews[2] as! UIButton
        
        let selColor = UIColor.init(red: 0, green: 224/255, blue: 198/255, alpha: 1)
        let deSelColor = UIColor.darkGrayColor()
        
        if scale <= 0.6 {
            leftBtn.setTitleColor(selColor, forState: UIControlState.Normal)
            centerBtn.setTitleColor(deSelColor, forState: UIControlState.Normal)
            rghtBtn.setTitleColor(deSelColor, forState: UIControlState.Normal)
        }
            else if scale <= 1.6 {
            leftBtn.setTitleColor(deSelColor, forState: UIControlState.Normal)
            centerBtn.setTitleColor(selColor, forState: UIControlState.Normal)
            rghtBtn.setTitleColor(deSelColor, forState: UIControlState.Normal)
        }
        else {
            leftBtn.setTitleColor(deSelColor, forState: UIControlState.Normal)
            centerBtn.setTitleColor(deSelColor, forState: UIControlState.Normal)
            rghtBtn.setTitleColor(selColor, forState: UIControlState.Normal)
        }

        slider.center.x = leftBtn.center.x
        let x =  centerBtn.center.x - leftBtn.center.x
        slider.transform = CGAffineTransformMakeTranslation(scale * x , 0)
    }
    
    
    
    
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        discoverScrollView.frame = CGRectMake(0, 0, width, height)
        let tmpWidth:CGFloat = width
        let tmpHight:CGFloat = height
        let tmpOffsetX:CGFloat = discoverScrollView.contentOffset.x
        let index:NSInteger = NSInteger (tmpOffsetX / tmpWidth)
        let willShowVC:UIViewController = self.childViewControllers[index]
        if (willShowVC.isViewLoaded() == true){
            return
        } else {
            willShowVC.view.frame = CGRectMake(tmpOffsetX, 0, tmpWidth, tmpHight)
            discoverScrollView.addSubview(willShowVC.view)
        }
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       discoverScrollView.frame = CGRectMake(0, 0, width, height)
        let tmpWidth:CGFloat = width
        let tmpHight:CGFloat = height
        let tmpOffsetX:CGFloat = discoverScrollView.contentOffset.x
        let index:NSInteger = NSInteger (tmpOffsetX / tmpWidth)
        let willShowVC:UIViewController = self.childViewControllers[index]
        willShowVC.setNeedsStatusBarAppearanceUpdate()
        if (willShowVC.isViewLoaded() == true){
            return
        } else {
            willShowVC.view.frame = CGRectMake(tmpOffsetX, 0, tmpWidth, tmpHight)
            discoverScrollView.addSubview(willShowVC.view)
        }
    }

    @IBAction func titleBtnDidTouch(sender: UIButton) {
        let btnTag = sender.tag
        var offset = discoverScrollView.contentOffset
        offset.x = CGFloat(btnTag) * discoverScrollView.frame.size.width
        discoverScrollView.setContentOffset(offset, animated: true)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    @IBAction func searchBtnDidTouch(sender: AnyObject) {
        let toView = SearchViewController(nibName: "SearchViewController", bundle: nil )
        toView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toView, animated: true)
        
    }
    
}
