//
//  TileView.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class TileView: UIView {

    //颜色映射表，不同的数字颜色不同
    let colorMap = [
        2:UIColor.red,
        4:UIColor.orange,
        8:UIColor.yellow,
        16: UIColor.green,
        32:UIColor.brown,
        64:UIColor.blue,
        128:UIColor.purple,
        256:UIColor.cyan,
        512:UIColor.lightGray,
        1024:UIColor.magenta,
        2048:UIColor.black
    ]
    
    
    //在设置值时，更新视图的背景和文字
    
    var value:Int = 0{
        didSet{
                backgroundColor = colorMap[value]
                numberLabel.text = "\(value)"
        }
    }
    

    var numberLabel: UILabel!
    
    init(pos:CGPoint, width:CGFloat, value:Int) {
        numberLabel = UILabel(frame:CGRect(x: 0, y: 0, width: width, height: width))
        numberLabel.textColor = UIColor.white
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont(name:"微软雅黑", size:20)
        numberLabel.text = "\(value)"
        super.init(frame:CGRect(x: pos.x, y: pos.y, width: width, height: width))
        addSubview(numberLabel)
        self.value = value
        backgroundColor = colorMap[value]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
