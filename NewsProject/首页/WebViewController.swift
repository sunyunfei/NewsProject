//
//  WebViewController.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var homeModel:HomeModel?
    var webView:UIWebView?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = homeModel?.title
        webView = UIWebView.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height))
        self.view.addSubview(webView!)
        
        //加载网页数据
        let url = NSURL(string:(homeModel?.url)!)
        let request = NSURLRequest(url:url as! URL)
        webView?.loadRequest(request as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
