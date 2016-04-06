//
//  TestViewController.swift
//  YouYuApp
//
//  Created by Hongbo Yu on 16/3/28.
//  Copyright © 2016年 Frank. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
