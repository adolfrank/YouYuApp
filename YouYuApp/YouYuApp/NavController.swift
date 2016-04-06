//
//  NavController.swift
//  11-day
//
//  Created by Hongbo Yu on 16/3/24.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavImage()
    }
    
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        //  这个方法可以拦截所有通过导航栏进来的push
        //  可以通过此方法自定义导航栏的图标
        super.pushViewController(viewController, animated: animated)
    }

    
    
    
    // MARK: - 找出导航栏地步的黑条
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView?
    {
        if let imageView = view as? UIImageView where imageView.bounds.height <= 1
        {
            return imageView
        }
        for subview: UIView in view.subviews
        {
            if let imageView = hairlineImageViewInNavigationBar(subview)
            {
                return imageView
            }
        }
        return nil
    }
    // MARK: - 隐藏导航栏的黑条
    func hideNavImage(){
        let NavImage: UIImageView = self.hairlineImageViewInNavigationBar(self.navigationBar)!
        NavImage.hidden = true
    }

    

}