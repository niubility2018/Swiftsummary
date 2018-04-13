//
//  SocketClientController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/4.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import SwiftSocket

class SocketClientController: UIViewController {

    //消息输入框
    var textFiled: UITextField!
    //消息输出列表
    var textView: UITextView!
    
    //socket服务端封装类对象
    var socketServer: MyTcpSocketServer?
    //socket客户端类对象
    var socketClient:TCPClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        textFiled = UITextField(frame: CGRect(x: 20, y: 64, width: 200, height: 50))
        textFiled.backgroundColor = .orange
        self.view.addSubview(textFiled)
        
        textView = UITextView(frame: CGRect(x: 20, y: 120, width: 300, height: 300))
        textView.backgroundColor = .red
        self.view.addSubview(textView)
        
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: UIScreen.main.bounds.size.width-50-20, y: 64, width: 50, height: 50)
        btn.setTitle("发送", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(sendMsg), for: .touchUpInside)
        self.view.addSubview(btn)
        
        
        //启动服务器
        socketServer = MyTcpSocketServer()
        socketServer?.start()
        
        //初始化客户端，并连接服务器
//        processClientSocket()
    }
    
    //初始化客户端，并连接服务器
//    func processClientSocket(){
//        socketClient=TCPClient(address: "localhost", port: 8080)
//
//        DispatchQueue.global(qos: .background).async {
//            //用于读取并解析服务端发来的消息
//            func readmsg()->[String:Any]?{
//                //read 4 byte int as type
//                if let data=self.socketClient!.read(4){
//                    if data.count==4{
//                        let ndata=NSData(bytes: data, length: data.count)
//                        var len:Int32=0
//                        ndata.getBytes(&len, length: data.count)
//                        if let buff=self.socketClient!.read(Int(len)){
//                            let msgd = Data(bytes: buff, count: buff.count)
//                            if let msgi = try? JSONSerialization.jsonObject(with: msgd,
//                                                                            options: .mutableContainers) {
//                                return msgi as? [String:Any]
//                            }
//                        }
//                    }
//                }
//                return nil
//            }
//
//            //连接服务器
//            switch self.socketClient!.connect(timeout: 5) {
//            case .success:
//                DispatchQueue.main.async {
//                    self.alert(msg: "connect success", after: {
//                    })
//                }
//
//                //发送用户名给服务器（这里使用随机生成的）
//                let msgtosend=["cmd":"nickname","nickname":"游客\(Int(arc4random()%1000))"]
//                self.sendMessage(msgtosend: msgtosend)
//
//                //不断接收服务器发来的消息
//                while true{
//                    if let msg=readmsg(){
//                        DispatchQueue.main.async {
//                            self.processMessage(msg: msg)
//                        }
//                    }else{
//                        DispatchQueue.main.async {
//                            //self.disconnect()
//                        }
//                        //break
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.alert(msg: error.localizedDescription,after: {
//                    })
//                }
//            }
//        }
//    }
    
    //“发送消息”按钮点击
    @objc func sendMsg(_ sender: AnyObject) {
        let content=textFiled.text!
        let message=["cmd":"msg","content":content]
        self.sendMessage(msgtosend: message)
        textFiled.text=nil
    }
    
    //发送消息
    func sendMessage(msgtosend:[String:String]){
        let msgdata=try? JSONSerialization.data(withJSONObject: msgtosend,
                                                options: .prettyPrinted)
        var len:Int32=Int32(msgdata!.count)
        let data = Data(bytes: &len, count: 4)
//        _ = self.socketClient!.send(data: data)
//        _ = self.socketClient!.send(data:msgdata!)
    }
    
    //处理服务器返回的消息
    func processMessage(msg:[String:Any]){
        let cmd:String=msg["cmd"] as! String
        switch(cmd){
        case "msg":
            self.textView.text = self.textView.text +
                (msg["from"] as! String) + ": " + (msg["content"] as! String) + "\n"
        default:
            print(msg)
        }
    }
    
    //弹出消息框
    func alert(msg:String,after:()->(Void)){
        let alertController = UIAlertController(title: "",
                                                message: msg,
                                                preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        //1.5秒后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            alertController.dismiss(animated: false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
