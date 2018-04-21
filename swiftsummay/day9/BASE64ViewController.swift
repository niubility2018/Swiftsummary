//
//  BASE64ViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/16.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class BASE64ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        //获取图片数据
        let file = Bundle.main.path(forResource: "swift", ofType: "png")!
        let fileUrl = URL(fileURLWithPath: file)
        let fileData = try! Data(contentsOf: fileUrl)
        
        //将图片转为base64编码
        let base64 = fileData.base64EncodedString(options: .endLineWithLineFeed)
            .addingPercentEncoding(withAllowedCharacters: .alphanumerics)//替换斜杠为%
        print(base64!)
        
        
        
        
        
        //Base64字符串（urlEncoded处理过）
        
        //获取图片数据
        let imageData = Data(base64Encoded: base64!.removingPercentEncoding!)
        
        //显示图片
//        imageView.image = UIImage(data: imageData!)
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 200, height: 200))
        imageView.image = UIImage(data: imageData!)
        view.addSubview(imageView)
        
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
