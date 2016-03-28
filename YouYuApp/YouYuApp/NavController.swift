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
        // Do any additional setup after loading the view.
    }
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        //  这个方法可以拦截所有通过导航栏进来的push
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

/*  找出导航栏的黑条
extension UIToolbar
{
    
    func hideHairline()
    {
        let navigationBarImageView = hairlineImageViewInToolbar(self)?.hidden = true
    }
    
    func showHairline()
    {
        let navigationBarImageView = hairlineImageViewInToolbar(self)?.hidden = false
    }
    
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView?
    {
        if let imageView = view as? UIImageView where imageView.bounds.height <= 1
        {
            return imageView
        }
        
        for subview: UIView in view.subviews
        {
            if let imageView = hairlineImageViewInToolbar(subview)
            {
                return imageView
            }
        }
        
        return nil
    }
    
}
 */
