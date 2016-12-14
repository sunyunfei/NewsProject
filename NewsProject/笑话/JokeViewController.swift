//
//  JokeViewController.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var dataArray = [JokeModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "笑话"
        //加载表
        self.p_loadTableView()
        self.p_loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //数据加载 
    func p_loadData(){
    
        let url = NSURL(string:"http://japi.juhe.cn/joke/content/list.from?sort=desc&page=&pagesize=20&time=1418816972&key=4fe6c22709de83b669fec46cfc281f23")
        let session = URLSession.shared
        let request = NSURLRequest.init(url: url as! URL)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if data != nil{
            
                //把请求回来的data转换
                let result = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
                let result2:[String:AnyObject] = (result!!["result"] as? [String:AnyObject])!
                let array:[AnyObject] = result2["data"] as! [AnyObject]
                for dic in array{
                
                    let model = JokeModel.init(dic:dic as! [String:AnyObject])
                    self.dataArray.append(model)
                }
                //刷新
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        })
        task.resume()
    }
    
    func p_loadTableView(){
    
        tableView = UITableView.init(frame: self.view.bounds)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        //注册
        tableView?.register(JokeCell.classForCoder(), forCellReuseIdentifier: "JokeCell")
        self.view.addSubview(tableView!)
    }

    //代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:JokeCell = (tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as? JokeCell)!
        cell.jokeModel = dataArray[indexPath.row];
        return cell;
    }
    //返回高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return JokeCell.cellHeightForModel(model: dataArray[indexPath.row])
    }
}
