//
//  SearchViewController.swift
//  YouYuApp
//
//  Created by Hongbo Yu on 16/3/30.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit




class SearchViewController: UIViewController, UIGestureRecognizerDelegate, UISearchResultsUpdating , UITableViewDelegate, UITableViewDataSource{

    
    let data = ["去你的撒哈拉", "春游便当", "一枚CCTV镜头盖走过的路途", "小人物的光芒",
                "一座有故事的城市", "斯坦森的愚人节魔性广告", "人工智能「27」号的一生", "星星的孩子",
                "人心翻译机，你值得拥有", "如何变的充满创造力", "假装不经意间想到你", "这一刻，他已经等待太久"]
    var filteredData: [String]!
    var searchData: NSArray?
    var searchController : UISearchController!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButtonWithImage()
        
        // MARK: 设置搜索栏
        searchController = UISearchController(searchResultsController: nil)
        searchController.loadViewIfNeeded()
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        definesPresentationContext = true  // 此方法可去除一个报错
        
        filteredData = data
        
        let filepath = NSBundle.mainBundle().pathForResource("HomeTableData", ofType: "plist")
        searchData = NSArray(contentsOfFile: filepath!)

        let cell = UINib(nibName: "SearchResultCell", bundle: nil)
        searchTableView.registerNib(cell, forCellReuseIdentifier: "resultCell")
        
    }
    
    
    deinit {
        searchController.loadViewIfNeeded()
    }
    
    
    //MARK:  导航栏的相关设置
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setBackButtonWithImage()  {
        let backImg: UIImage = UIImage(named: "backBtn")!
        let leftBtn: UIBarButtonItem = UIBarButtonItem(image: backImg, style: .Done, target: self, action:#selector(SearchViewController.goToBack))
        self.navigationItem.leftBarButtonItem = leftBtn
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func goToBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    // MARK: 滚动表格让键盘退出
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
    
    
    // MARK: tableView的一些设置
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCellWithIdentifier("resultCell") as! SearchResultCell
        cell.textLabel?.text = filteredData[indexPath.row]
        cell.imageView?.image = UIImage(named: searchData![indexPath.row]["headerAvatar"] as! String)
        cell.textLabel?.font = UIFont.systemFontOfSize(16)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchTableView.deselectRowAtIndexPath(indexPath, animated: true)

        // MARK: 要跳转到由storyboard创建的控制器的方法
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toView =  storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        // MARK: 设置数据传递
        toView.textToGo =  (searchData![indexPath.row]["sectionData"]!![0]["title"] as? String)!
        toView.imageToGo = (searchData![indexPath.row]["sectionData"]!![0]["image"] as? String)!
        toView.avatarToGo = (searchData![indexPath.row]["sectionData"]!![0]["avatar"] as? String)!
        toView.plistToGo = (searchData![indexPath.row]["sectionData"]!![0]["plistToGo"] as? String)!
        toView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toView, animated: true)
    }
    
    
    // MARK: 设置搜索栏的搜索数据
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
            searchTableView.reloadData()
        }
    }

    
   
}
