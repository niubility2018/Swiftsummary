//
//  ImageViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/10.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

extension UIImage{
    func toCircle() -> UIImage {
        //去最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outPutRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outPutRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        
        //添加圆形裁剪区域
        context.addEllipse(in: outPutRect)
        context.clip()
        self.draw(in: CGRect(x: (shotest-self.size.width)/2, y: (shotest-self.size.height)/2, width: self.size.width, height: self.size.height))
        
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
}

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        imageView.image = UIImage(named: "swift")?.toCircle()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = imageView.frame.size.width/2
        self.view.addSubview(imageView)
        
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
