//
//  YouyuTabBar.swift
//  YouYuApp
//
//  Created by Adolfrank on 4/3/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class YouyuTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        //MARK: 设置tabBar的样式
        self.barStyle = UIBarStyle.Black
        self.translucent = false
        //MARK: 自定义tabBar按钮的布局：把左右两个按钮的位置往中间移动了 27（btnX）个单位
        let btnY: CGFloat = 0
        let btnW: CGFloat = (self.frame.size.width - 24) / 4
        let btnH: CGFloat = self.frame.size.height
        var btnX: CGFloat = 12
        for button: UIView in self.subviews {
            if !(button.isKindOfClass(UIControl)) {
                continue
            } else {
                button.frame = CGRectMake(btnX, btnY , btnW, btnH)
                btnX = btnX + btnW
            }
        }
    }
}
