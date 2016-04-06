//
//  SelectedViewController.swift
//  YouYuApp
//
//  Created by Adolfrank on 4/4/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit


class SelectedViewController: UICollectionViewController, WaterFlayoutDelegate, LSImgZoomViewDelegate {

    var selectedData: NSArray?
    var content_y =  CGFloat()
    var lastOffset = CGFloat()
    let SrceenHeight = UIScreen.mainScreen().bounds.height
    let Srceenwidth = UIScreen.mainScreen().bounds.width
    
    @IBOutlet var selectedCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIView()
        vc.frame = CGRectMake(0, -64 , Srceenwidth, 64)
        vc.backgroundColor = UIColor.whiteColor()
        self.view.insertSubview(vc, belowSubview: selectedCollection)
        
        let filepath = NSBundle.mainBundle().pathForResource("collectionCellList", ofType: "plist")
        selectedData = NSArray(contentsOfFile: filepath!)
        
        selectedCollection.delegate = self
        selectedCollection.dataSource = self
        selectedCollection.contentInset = UIEdgeInsetsMake(0, 0, 69, 0)
        
        self.automaticallyAdjustsScrollViewInsets = true
        self.navigationController?.hidesBarsOnSwipe = true
    }

    
    
    
    override func viewDidAppear(animated: Bool) {
        selectedCollection.frame = CGRectMake(0, 0, Srceenwidth, SrceenHeight)
    }
   

    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (selectedData?.count)!
    }
 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = selectedCollection.dequeueReusableCellWithReuseIdentifier("selectedCell", forIndexPath: indexPath) as! SelectedCell
        cell.backgroundColor = UIColor.grayColor()
        cell.selTitle.text = selectedData![indexPath.item]["title"] as? String
        cell.selImage.image = UIImage(named: (selectedData![indexPath.item]["image"] as? String)!)
        return cell
    }

    // MARK: collectionView的布局
    func collectionView(collectionview:UICollectionView,layout:UICollectionViewLayout,indexPath:NSIndexPath) ->CGSize {
        let item_w = (selectedCollection.frame.size.width-24)*0.5
        let item_img = UIImage(named: (selectedData![indexPath.item]["image"] as? String)!)
        let imgsize = item_img!.size
        let img_h =  (imgsize.height*item_w)/imgsize.width
        return CGSizeMake(item_w, img_h)
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //  重置offset值，不然滚动是navBar隐藏会有bug
        content_y = selectedCollection.contentOffset.y
        lastOffset = selectedCollection.contentOffset.y
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let cell = selectedCollection.cellForItemAtIndexPath(indexPath) as! SelectedCell
        cell.selImage.hidden = true
        let baseframe = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-content_y, cell.frame.size.width, cell.frame.size.height)
        let zoomv = LSImgZoomView(baseframe: baseframe)
        zoomv.delegate = self
        zoomv.setCurrImg(cell.selImage.image!)
        zoomv.show()
        zoomv.blockClose = {(done:Bool) -> Void in
            cell.selImage.hidden = false
        }
    }
 
    
    func lsImgZoomView(close: Bool) {
        if (close){
        }
    }
    
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        content_y = scrollView.contentOffset.y
        //  往下滚动，设置navBar和tabBar隐藏
        //  原理：根据当下滚动的offset值与上一次滚动的offset值的差值，正数为往下滚，负数为往上滚
        if ((content_y - lastOffset) > 30) {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            let tabBar = self.tabBarController?.tabBar
            let duration: NSTimeInterval = 0.3
            //  其实就是把tabBar的位置改到frame的正下方刚好看不见的地方
            UIView.animateWithDuration (duration, animations: {
                tabBar!.frame = CGRectMake(0, self.SrceenHeight, self.Srceenwidth, (tabBar?.frame.height)!)
                })
        }
        //  往上滚动，设置navBar和tabBar显示
        else if ((content_y - lastOffset) < -60){
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
            //  把tabBar从下方显示出来
            let tabBar = self.tabBarController?.tabBar
            let duration: NSTimeInterval = 0.3
            UIView.animateWithDuration(duration, animations: {
                tabBar!.frame = CGRectMake(0, self.SrceenHeight - (tabBar?.frame.height)!, self.Srceenwidth, (tabBar?.frame.height)!)
            })
        } else {return}
    }
    

  
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastOffset =  scrollView.contentOffset.y
    }
    
    // 停止拖动的时候，navBar也能显示出来
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        content_y = scrollView.contentOffset.y
        if ((content_y - lastOffset) < -50){
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return (navigationController?.navigationBarHidden)!
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
}
