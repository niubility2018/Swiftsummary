//
//  JSONViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/2.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class JSONViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel(frame:CGRect(x:100, y:100, width:300, height:100))
        label.text = "输出结果在控制台"
        self.view.addSubview(label)
        //测试结果在output终端输入，也可以建个命令行应用测试就可以了
        testJson()
    }
    
    func testJson() {
        let user: [String: Any] = [
            "uname": "张三",
            "tel": ["mobile": "138", "home": "010"]
        ]
        
        //首先判断能不能转换
        if !(JSONSerialization.isValidJSONObject(user)) {
            print("is not a valid json object")
            return
        }
        
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let data = try? JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
        //Data转换成String打印输出
        
        let str = String(data: data!, encoding: .utf8)
        
        print("json str:")
        print(str!)
        
        
        //把Data对象转换回JSON对象
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
        
        print("json object:", json!)
        
        let uname = json?["uname"]
        let mobile = (json?["tel"] as! [String: Any])["mobile"]
        print("get Json Object:","uname: \(uname!), mobile: \(mobile!)")
        
        
        let string = "[{\"ID\":1,\"Name\":\"元台禅寺\",\"LineID\":1},{\"ID\":2,\"Name\":\"田坞里山塘\",\"LineID\":1},{\"ID\":3,\"Name\":\"滴水石\",\"LineID\":1}]"
        let data1 = string.data(using: .utf8)
        
        let jsonArr = try! JSONSerialization.jsonObject(with: data1!,
                                                        options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
        
        print("记录数：\(jsonArr.count)")
        for json in jsonArr {
            print("ID：", json["ID"]!, "    Name：", json["Name"]!)
        }
        
        
        
        let alertView = UIAlertController(title: "提示", message: "请输入用户名和密码", preferredStyle: .alert)
        alertView.addTextField { (textField: UITextField) in
            textField.placeholder = "用户名"
        }
        
        alertView.addTextField { (textField: UITextField) in
            textField.placeholder = "密码"
            textField.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (action) in
            let login = alertView.textFields?.first
            let pwd = alertView.textFields?.last
            print("用户名：\(String(describing: login?.text))  ， 密码：\(String(describing: pwd?.text))")
        }
        
        alertView.addAction(cancelAction)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
