//
//  JokeCell.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import UIKit

class JokeCell: UITableViewCell {

    var timeLabel:UILabel?
    var desLabel:UILabel?
    var jokeModel:JokeModel?{
    
        didSet{
        
            //数据加载
            self.updateUI()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //加载ui
        timeLabel = UILabel.init(frame:CGRect(x:5,y:5,width:self.contentView.frame.size.width - 10,height:20))
        timeLabel?.font = UIFont.systemFont(ofSize: 12)
        timeLabel?.textColor = UIColor.red
        self.contentView.addSubview(timeLabel!)
        
        desLabel = UILabel.init()
        desLabel?.font = UIFont.systemFont(ofSize: 14)
        desLabel?.textColor = UIColor.gray
        desLabel?.numberOfLines = 0
        self.contentView.addSubview(desLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(){
    
        timeLabel?.text = jokeModel?.updatetime;
        desLabel?.text = jokeModel?.content
        //计算高度
        let width = self.contentView.frame.size.width - 5 - 5
        let str:String = jokeModel!.content!
        let dic:NSDictionary = [NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        let size = CGSize.init(width: width, height: CGFloat(MAXFLOAT))
        let sizeDes:CGSize = str.boundingRect(with:size, options: .usesLineFragmentOrigin, attributes: dic as? [String : Any], context: nil).size
        
        desLabel?.frame = CGRect(x:5,y:5 + (self.timeLabel?.frame.size.height)! + 5,width:width,height:sizeDes.height)
        
    }
    
    //返回cell高度
    class func cellHeightForModel(model:JokeModel) ->CGFloat {
    
        let width = UIScreen.main.bounds.size.width - 5 - 5
        let str:String = model.content!
        let dic:NSDictionary = [NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        let size = CGSize.init(width: width, height: CGFloat(MAXFLOAT))
        let sizeDes:CGSize = str.boundingRect(with:size, options: .usesLineFragmentOrigin, attributes: dic as? [String : Any], context: nil).size
        
        return sizeDes.height + 5 + 5 + 20 + 5
    }
    
}
