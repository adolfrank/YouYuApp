//
//  TabBarController.swift
//  YouYuApp
//
//  Created by Adolfrank on 3/27/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        //  背景色
        // self.tabBar.barTintColor = UIColor.whiteColor()
        //  文字颜色
        // self.tabBar.tintColor = UIColor.init(red: 0, green: 224/255, blue: 198/255, alpha: 1)
        
        //  设置选中和为选中状态的文字颜色
        let tabColorSel = UIColor.init(red: 0, green: 224/255, blue: 198/255, alpha: 1)
        let TabColor = UIColor.init(red: 177/255, green: 177/255, blue: 177/255, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName:TabColor], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName:tabColorSel], forState:.Selected)
        //MARK: 自定义tabBar：把tabBar类修改为自己的类
        let yytabBar = YouyuTabBar()
        self.setValue(yytabBar, forKey: "tabBar")
    
    
    }


    
    
    
}
