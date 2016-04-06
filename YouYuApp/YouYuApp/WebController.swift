//
//  WebController.swift
//  YouYuApp
//
//  Created by Adolfrank on 4/3/16.
//  Copyright © 2016 Frank. All rights reserved.
//

import UIKit

class WebController: UIViewController, UIGestureRecognizerDelegate, UIWebViewDelegate {

    var titleToGo:String = ""
    var urlToGo: String = ""
    
    @IBOutlet weak var youyuWebView: UIWebView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithImage()
        setShareButtonWithImage()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       
        let url = NSURL(string: urlToGo)
        let request = NSURLRequest(URL: url!)
        youyuWebView.loadRequest(request)
        
        
        youyuWebView.scalesPageToFit = true
        youyuWebView.delegate = self
        
    }

    
    
    func setBackButtonWithImage()  {
        let backImg: UIImage = UIImage(named: "backBtn")!
        let leftBtn: UIBarButtonItem = UIBarButtonItem(image: backImg, style: .Done, target: self, action:#selector(WebController.goToBack))
        self.navigationItem.leftBarButtonItem = leftBtn
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func goToBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    
    func setShareButtonWithImage()  {
        let shareImg: UIImage = UIImage(named: "action_shareG")!
        let rightBtn: UIBarButtonItem = UIBarButtonItem(image: shareImg, style: .Done, target: self, action:#selector(WebController.sharePage))
        self.navigationItem.rightBarButtonItem = rightBtn
    }

    
    func sharePage() {
        let activityViewController = UIActivityViewController(
            activityItems: [urlToGo as String],
            applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
                          
    
    //UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
         self.title = titleToGo
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.title = "加载中..."
    }
   
    
}
