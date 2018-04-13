//
//  JuZhenViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class JuZhenViewController: UIViewController {

    
     //游戏方格维度
    var dimension:Int = 4
    
    //数字格子的就宽度
    var width:CGFloat = 50
    
    //格子之间间距
    var padding:CGFloat = 6
    
    //保存背景图数据
    var backgrounds:Array<TileView>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.backgrounds = Array<TileView>()
        setupGameMap()
    }
    
    func setupGameMap() {
        var x:CGFloat = 50
        var y:CGFloat = 150
        for i in 0..<dimension {
            print(i)
            y = 150
            for _ in 0..<dimension {
                //随机2的1～11次方
                let val:Int = 2<<Int(arc4random_uniform(10))
                //初始化视图
                let background = TileView(pos: CGPoint(x: x, y: y), width: self.width, value: val)
                self.view.addSubview(background)

                //将视图保存起来，以备后用
                backgrounds.append(background)
                y += padding + width
            }
            x += padding + width
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
