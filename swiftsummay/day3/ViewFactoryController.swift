//
//  ViewFactoryController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

struct Poker {
    enum Suit:String {
        case Heart="红桃",Club="草花", Diamond="方片", Spade="黑桃"
    }
    
    enum Number:Int {
        case Two=2, Three, Four, Five,Six,Seven,Eight,Nine,Ten
        case Jack,Queen,King,Ace
    }
    
    let suit:Suit
    let number:Number
    
    func description() {
        print("这张牌的花色是\(suit.rawValue)，牌的面值是\(number.rawValue)")
    }
}

extension String {
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}


class JsonElement {
    var name: String = ""
    var jValue: String?
    
    lazy var asJson:() -> String = {
        [unowned self] in //使用无主引用来解决强引用循环
        if let text = self.jValue {
            return "\(self.name):\(text)"
        }else{
            return "text is nil"
        }
    }
    
    init(name:String, text:String){
        self.name = name
        self.jValue = text
        print("初始化闭包")
    }
    
    deinit{
        print("闭包释放")
    }
    
}


class ViewFactoryController: UIViewController,UITextFieldDelegate {

    var txtNum:UITextField!
    var segDimension:UISegmentedControl!
    var btn:UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupControls()
        
        let value = 1<<4  //2的4次方
        let value1 = 1<<Int(arc4random_uniform(5))//2的0~4随机次方（包括0,4）
        print(value)
        print(value1)
        
        let card = Poker(suit: .Heart, number: .Jack)
        card.description()
        
        
       let bgImageView = UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100))
        bgImageView.backgroundColor = .orange
        self.view.addSubview(bgImageView)
//        使用系统URLSession 网络请求
        let url = URL(string: "http://hangge.com/blog/images/logo.png")
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)
                DispatchQueue.main.async {
                    bgImageView.image = img
                }
                
            }
        }
        dataTask.resume()
        
        
        
        let str1 = "欢迎访问hangge.com。hangge.com做最好的开发者知识平台"
        let str2 = "hangge"
        print("父字符串：\(str1)")
        print("子字符串：\(str2)")
        
        let position1 = str1.positionOf(sub: str2)
        print("子字符串第一次出现的位置是：\(position1)")
        let position2 = str1.positionOf(sub: str2, backwards: true)
        print("子字符串最后一次出现的位置是：\(position2)")
        
        
        
        let str3 = String(str1.reversed())
        print(str3)
        
        //使用类方法
//        Thread.detachNewThreadSelector(#selector(downLoadImage), toTarget: self, with: nil)
        
        
        //实例方法
//        let thread = Thread(target: self, selector: #selector(downLoadImage), object: nil)
//        thread.start()
        
//Operation
//        let operation = BlockOperation { [weak self] in
//            self?.downLoadImage()
//            return
//        }
//
//        let queue = OperationQueue()
//        queue.addOperation(operation)
        
        
        DispatchQueue.global(qos: .default).async {
            print("do work")
//            self.downLoadImage()
            DispatchQueue.main.async {
                print("main refresh")
            }
        }
        
        
        //获取系统存在的全局队列
        let queue = DispatchQueue.global(qos: .default)
        
        queue.async {
            DispatchQueue.concurrentPerform(iterations: 6, execute: { (index) in
                print(index)
            })
            
            DispatchQueue.main.async {
                print("done")
            }
            
        }
        
    }
    
    @objc func downLoadImage() {
        let imageUrl = "http://hangge.com/blog/images/logo.png"
        let data = try! Data(contentsOf: URL(string: imageUrl)!)
        print("------------",data.count)
    }
    
    
    func setupControls()
    {
        //创建文本标签
        let labelNum = ViewFactory.createLabel(title: "阈值:")
        labelNum.frame = CGRect(x: 20, y: 100, width: 60, height: 30)
        self.view.addSubview(labelNum)
        
        let labelDm = ViewFactory.createLabel(title: "维度:")
        labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
        self.view.addSubview(labelDm)
        
        //创建文本输入框
        txtNum = ViewFactory.createTextField(value: "", sender:self)
        txtNum.frame = CGRect(x:80,y:100,width:200,height:30)
        txtNum.returnKeyType = UIReturnKeyType.done
        self.view.addSubview(txtNum)
        
        //创建分段单选控件
        segDimension = ViewFactory.createSegment(items: ["3x3", "4x4", "5x5"],
                                                 action:Selector(("dimensionChanged:")), sender:self)
        segDimension.frame = CGRect(x:80,y: 200,width: 200,height: 30)
        self.view.addSubview(segDimension)
        segDimension.selectedSegmentIndex = 1
        
        //创建按钮控件
        btn = ViewFactory.createButton(title: "确定",sender: self)
        btn.frame.origin = CGPoint(x: 80, y: 300)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnClick() {
        print("点击了")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        txtNum.resignFirstResponder()
        //打印出文本框中的值
        print(txtNum.text!)
        return true
    }
    
    func dimensionChanged(sender:AnyObject) {
        print("dimensionChanged")
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
