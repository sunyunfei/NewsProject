//
//  JokeModel.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import UIKit

class JokeModel: NSObject {

    var content:String?
    var updatetime:String?
    
    //创建一个加载dic方法
    init(dic:[String:AnyObject]){
    
        self.content = dic["content"] as! String?
        self.updatetime = dic["updatetime"] as! String?
    }
}
