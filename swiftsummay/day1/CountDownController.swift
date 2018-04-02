//
//  CountDownController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/30.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class CountDownController: UIViewController {
    var  ctimer:UIDatePicker!
    var btnstart:UIButton!
    
    var leftTime:Int = 180
    var alertController:UIAlertController!
    
    var timer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        ctimer = UIDatePicker(frame:CGRect(x:0, y:120, width:200, height:200))
        self.ctimer.datePickerMode = UIDatePickerMode.countDownTimer
        
        //必须为 60 的整数倍，比如设置为100，值自动变为 60
        DispatchQueue.main.async{
            self.ctimer.countDownDuration = TimeInterval(self.leftTime);
        }
        ctimer.addTarget(self, action: #selector(CountDownController.timerChanged),
                         for: .valueChanged)
        
        self.view.addSubview(ctimer)
        
        btnstart =  UIButton(type: .system)
        btnstart.frame = CGRect(x:100, y:400, width:100, height:100);
        btnstart.setTitleColor(UIColor.red, for: .normal)
        btnstart.setTitleColor(UIColor.green, for:.disabled)
        btnstart.setTitle("开始", for:.normal)
        btnstart.setTitle("倒计时中", for:.disabled)
        
        btnstart.clipsToBounds = true
        btnstart.layer.cornerRadius = 5
        btnstart.addTarget(self, action:#selector(CountDownController.startClicked),
                           for:.touchUpInside)
        
        self.view.addSubview(btnstart)
    }
    
    
    @objc func timerChanged()
    {
        print("您选择倒计时间为：\(self.ctimer.countDownDuration)")
    }
    
    /**
     *开始倒计时按钮点击
     */
    @objc func startClicked(sender:UIButton)
    {
        self.btnstart.isEnabled = false
        
        // 获取该倒计时器的剩余时间
        leftTime = Int(self.ctimer.countDownDuration);
        // 禁用UIDatePicker控件和按钮
        self.ctimer.isEnabled = false
        
        // 创建一个UIAlertController对象（警告框），并确认，倒计时开始
        alertController = UIAlertController(title: "系统提示",
                                            message: "倒计时开始，还有 \(leftTime) 秒...",
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        // 显示UIAlertController组件
        self.present(alertController, animated: true, completion: nil)
        
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target:self,
                                     selector:#selector(CountDownController.tickDown),
                                     userInfo:nil,repeats:true)
    }
    
    /**
     *计时器每秒触发事件
     **/
    @objc func tickDown()
    {
        alertController.message = "倒计时开始，还有 \(leftTime) 秒..."
        // 将剩余时间减少1秒
        leftTime -= 1;
        // 修改UIDatePicker的剩余时间
        self.ctimer.countDownDuration = TimeInterval(self.leftTime);
        print(leftTime)
        // 如果剩余时间小于等于0
        if(leftTime <= 0)
        {
            // 取消定时器
            timer.invalidate();
            // 启用UIDatePicker控件和按钮
            self.ctimer.isEnabled = true;
            self.btnstart.isEnabled = true;
            alertController.message = "时间到！"
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
