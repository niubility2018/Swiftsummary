//
//  XmlReaderController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/2.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class XmlReaderController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let label:UILabel = UILabel(frame:CGRect(x: 100, y: 100, width: 300, height: 100))
//        let attrStr = try? NSAttributedString(data: "&#xe827".data(using: String.Encoding.unicode)!, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
//        let string = attrStr?.string
        label.font =  UIFont.init(name: "iconFont", size: 20)
    
        label.text = "#funy-chuangkou"
        label.textColor = .blue
        self.view.addSubview(label)
        //测试Swift调用Object的XML库功能
        testXML()
    }
    
    func testXML() {
        
        //获取xml文件路径
        let file = Bundle.main.path(forResource: "users", ofType: "xml")
        let url = URL(fileURLWithPath: file!)
        //获取xml文件内容
        let xmlData = try! Data(contentsOf: url)
        //可以转换为字符串输出查看
        //print(String(data:xmlData, encoding:String.Encoding.utf8))
        //使用NSData对象初始化文档对象
        //这里的语法已经把OC的初始化函数直接转换过来了
        let doc:GDataXMLDocument = try! GDataXMLDocument(data:xmlData, options : 0)
        //获取Users节点下的所有User节点，显式转换为element类型编译器就不会警告了

        //let users = doc.rootElement().elements(forName: "User") as! [GDataXMLElement]

        //通过XPath方式获取Users节点下的所有User节点，在路径复杂时特别方便
        let users = try! doc.nodes(forXPath: "//User", namespaces:nil) as! [GDataXMLElement]
        for user in users {
            //User节点的id属性
            let uid = user.attribute(forName: "id").stringValue()
            //获取name节点元素
            let nameElement = user.elements(forName: "name")[0] as! GDataXMLElement
            //获取元素的值
            let uname = nameElement.stringValue()
            //获取tel子节点
            let telElement = user.elements(forName: "tel")[0] as! GDataXMLElement
            //获取tel节点下mobile和home节点
            let mobile = (telElement.elements(forName: "mobile")[0] as! GDataXMLElement).stringValue()
            let home = (telElement.elements(forName: "home")[0] as! GDataXMLElement).stringValue()
            //输出调试信息
            print("User: uid:\(uid!),uname:\(uname!),mobile:\(mobile!),home:\(home!)")
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
