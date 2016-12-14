//
//  HomeCell.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var date: UILabel!
    //数据
    var homeModel:HomeModel!{
    
        didSet{
        
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //图片自适应
        self.icon.contentMode = .scaleAspectFit
    }
    
    func updateUI(){
    
        self.nameLabel.text = homeModel.title;
        self.origin.text = homeModel.author_name
        self.date.text = homeModel.date
        
        //图片异步加载
        DispatchQueue.global().async {
           
            let url = NSURL(string:self.homeModel.thumbnail_pic_s!)
            let data = NSData(contentsOf: url! as URL)
            
            let image = UIImage(data:data as! Data)
            //主线城ui
            DispatchQueue.main.async {
              
                self.icon.image = image
            }
        }
    }
}
