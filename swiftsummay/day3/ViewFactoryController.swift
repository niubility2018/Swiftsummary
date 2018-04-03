//
//  ViewFactoryController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

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
