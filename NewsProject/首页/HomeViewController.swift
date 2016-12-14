//
//  HomeViewController.swift
//  NewsProject
//
//  Created by 孙云飞 on 2016/12/14.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

import UIKit
import SafariServices
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //数据表
    var tableView:UITableView?
    var dataArray = [HomeModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主页"
        self.p_loadTableView()
        self.refreshData(type: "top")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //数据的加载
    func refreshData(type:String){
    
        //网络请求
        let urlStr = "http://v.juhe.cn/toutiao/index?type=&key=848c3f852e0471b53e966832570d7308"
        let url = URL(string:urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){(Data,respond,error) in
        
            if let data = Data{
            
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]{
                
                    let result2:[String:AnyObject] = (result?["result"])! as! [String : AnyObject]
                    let result3:[AnyObject] = (result2["data"] as? [AnyObject])!
                    for dic in result3{
                    
                       let model = HomeModel.init(dic: dic as! [String : AnyObject])
                        
                        self.dataArray.append(model)
                    }
                    
                    //刷新表
                    DispatchQueue.main.async {
                       
                        self.tableView?.reloadData()
                    }
                    
                }
            }
        }
        dataTask.resume()
    }
    //表的加载
    func p_loadTableView(){
    
        tableView = UITableView.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 100
        //注册cell
        tableView?.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        self.view.addSubview((tableView)!)
    }
    
    //代理的加载
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataArray.count);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.homeModel = dataArray[indexPath.row];
        return cell;
    }

    //点击代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        //数据
        let model = dataArray[indexPath.row]
        /*
        let url = NSURL(string:model.url!)
        //显示网页方法
        //1
        let safari = SFSafariViewController(url:url as! URL)
        
        self.present(safari, animated: true, completion: nil)
         */
        //2
        
        let webVC = WebViewController()
        webVC.homeModel = model
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
