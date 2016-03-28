//
//  DiscoverViewController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/27/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController,UIScrollViewDelegate, UITableViewDelegate {

    @IBOutlet weak var discoverScrollView: UIScrollView!
   
    @IBAction func titleBtnDidTouch(sender: UIButton) {
        let btnTag = sender.tag
        var offset = discoverScrollView.contentOffset
        offset.x = CGFloat(btnTag) * discoverScrollView.frame.size.width
        discoverScrollView.setContentOffset(offset, animated: true)
    }

    
    let height:CGFloat = UIScreen.mainScreen().bounds.height
    let width:CGFloat = UIScreen.mainScreen().bounds.width
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        scrollViewDidEndScrollingAnimation(discoverScrollView)
        self.automaticallyAdjustsScrollViewInsets = false
        
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

    
     
    
}
