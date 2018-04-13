//
//  ScoreView.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

enum ScoreType {
    case common   //普通分数面板
    case best    //最高分数面板
}

//protocol ScoreViewProtocol {
//    func changeScore(value s:Int)
//}


class ScoreView: UIView {

    var label:UILabel!
    let defaultFrame = CGRect(x: 0, y: 0, width: 100, height: 30)
    var stype:String! //显示最高分还是分数
    
    var score:Int = 0{
        didSet{
            //分数变化，标签内容也要变化
            label.text = "\(stype!):\(score)"
        }
    }
    
    
    //传入分数面板的类型，用于控制标签的显示
    
    init(stype: ScoreType) {
        label = UILabel(frame:defaultFrame)
        label.textAlignment = .center
        
        super.init(frame:defaultFrame)
        
        self.stype = (stype == .common ? "分数":"最高分")
        backgroundColor = UIColor.orange
        label.font = UIFont(name:"微软雅黑", size:16)
        label.textColor = UIColor.white
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //实现协议中的方法
    func changeScore(value s:Int)
    {
        score = s
    }
}
