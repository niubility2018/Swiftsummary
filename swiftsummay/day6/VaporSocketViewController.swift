//
//  VaporSocketViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/11.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class VaporSocketViewController: UIViewController {
    //发送消息输入框
     var textField: UITextField!
    
    //用于显示接收到的消息
     var textView: UITextView!
    
    
    
    //TCP服务端
    var server:SynchronousTCPServer!
    
    //TCP客户端
    lazy var client:TCPClient? = {
        //初始化客户端
        let address = InternetAddress(hostname: "127.0.0.1", port: 8080)
        do {
            return try TCPClient(address: address)
        } catch {
            print("Error \(error)")
            return nil
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.textField = UITextField(frame: CGRect(x: 20, y: 70, width: 200, height: 50))
        self.textField.backgroundColor = UIColor.cyan
        view.addSubview(self.textField)
        
        self.textView = UITextView(frame: CGRect(x: 20, y: 200, width: 200, height: 400))
        self.textView.backgroundColor = .purple
        view.addSubview(self.textView)
        
        let sendBtn = UIButton(type: .custom)
        sendBtn.frame = CGRect(x: 240, y: 70, width: 50, height: 50)
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.backgroundColor = .orange
        sendBtn.addTarget(self, action: #selector(sendMessage(_:)), for: .touchUpInside)
        view.addSubview(sendBtn)
        
        

        // Do any additional setup after loading the view.
        startServer()
    }
    
    //启动服务器
    func startServer() {
        //在后台线程中启动服务器
        DispatchQueue.global(qos: .background).async {
            do {
                //初始化服务器
                self.server = try SynchronousTCPServer(port: 8080)
                
                //在界面上显示启动信息
                DispatchQueue.main.async {
                    let hostname = self.server.address.hostname
                    let address = self.server.address.addressFamily
                    let port = self.server.address.port
                    self.textView.text = "服务器启动，监听："
                        + "\"\(hostname)\" (\(address)) \(port)\n"
                }
                
                //接收并处理客户端连接
                try self.server.startWithHandler { (client) in
                    self.handleClient(client: client)
                }
            } catch {
                print("Error \(error)")
            }
        }
    }
    
    //处理连接的客户端
    func handleClient(client:TCPClient){
        do {
            while true{
                //获取客户端发送过来的消息：[UInt8]类型
                let data = try client.receiveAll()
                
                //将接收到的消息转成String类型
                let str = try data.toString()
                //将这个String消息显示到界面上
                DispatchQueue.main.async {
                    self.textView.text = self.textView.text + "服务端接收到消息: \(str)\n"
                }
                
                //将接收到的消息又发回客户端
                try client.send(bytes: data)
                
                //try client.close() //关闭与客户端链接
            }
        } catch {
            print("Error \(error)")
        }
    }
    
    //发送消息
    @objc func sendMessage(_ sender: Any) {
        do {
            let message = self.textField.text
            if message != nil && message != "" {
                try client?.send(bytes: message!.toBytes())
                let str = try client!.receiveAll().toString()
                //将服务端返回的消息显示在界面上
                self.textView.text = self.textView.text + "客户端接收到反馈: \(str)\n"
                //try client.close() //关闭客户端与服务端链接
                
                //清空输入框
                self.textField.text = ""
            }
        } catch {
            print("Error \(error)")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
