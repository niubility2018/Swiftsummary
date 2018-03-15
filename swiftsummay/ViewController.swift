//
//  ViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/14.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    //显示频道列表的tableView
    var tableView: UITableView!
    
    //频道列表数据
    var channels:Array<JSON> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
        
        
//        DouBanProvider.request(.channels) { result in
//            if case let .success(response) = result{
//                let data = try? response.mapJSON()
//                let json = JSON(data!)
//                self.channels = json["channels"].arrayValue
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
        Network.request(DouBan.channels, success: { (json) in
            self.channels = json["channels"].arrayValue
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, error: { (statusCode) in
            //服务器报错等问题
            print("请求错误！错误码：\(statusCode)")
        }) { (error) in
            //没有网络等问题
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftCell")
        cell?.textLabel?.text = channels[indexPath.row]["name"].stringValue
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelName = channels[indexPath.row]["name"].stringValue
        let channelId = channels[indexPath.row]["channel_id"].stringValue
        
//        DouBanProvider.request(DouBan.playlist(channelId)) { (result) in
//            if case let.success(response) = result {
//                let data = try? response.mapJSON()
//                let json = JSON(data!)
//                print(json)
//                let music = json["song"].arrayValue[0]
//                let artist = music["artist"].stringValue
//                let title = music["title"].stringValue
//                let message = "歌手：\(artist)\n歌曲：\(title)"
//                self.showAlert(title: channelName, message: message)
//            }
//        }
        
        Network.request(DouBan.playlist(channelId), success: { (json) in
            let music = json["song"].arrayValue[0]
            let artist = music["artist"].stringValue
            let title = music["title"].stringValue
            let message = "歌手：\(artist)\n歌曲：\(title)"
            self.showAlert(title: channelName, message: message)
        }, error: { (statusCode) in
            //服务器报错等问题
            print("请求错误！错误码：\(statusCode)")
        }) { (error) in
            //没有网络等问题
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        }
    }
    
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

