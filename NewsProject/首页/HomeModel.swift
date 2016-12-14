//
//  HomeModel.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import Foundation

class HomeModel:NSObject {

    var author_name: String? //作者
    var date: String? //时间
    var thumbnail_pic_s: String? //图片
    var title : String? //标题
    var url :String? //链接
    
    //加载
    init(dic: [String: AnyObject]){
    
        self.author_name = dic["author_name"] as? String
        self.date = dic["date"] as! String?
        self.thumbnail_pic_s = dic["thumbnail_pic_s"] as? String
        self.title = dic["title"] as? String
        self.url = dic["url"] as? String
    }
}
