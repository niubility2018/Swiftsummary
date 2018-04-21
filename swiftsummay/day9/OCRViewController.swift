//
//  OCRViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/16.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import SwiftyJSON
class OCRViewController: UIViewController {
    
    var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        self.textView = UITextView(frame: CGRect(x: 10, y: 100, width: 200, height: 300))
        
        self.textView.backgroundColor = .cyan
        view.addSubview(self.textView)
//
        // Do any additional setup after loading the view.
        //获取图片
        let file = Bundle.main.path(forResource: "wenzi", ofType: "jpg")!
        let fileUrl = URL(fileURLWithPath: file)
        let fileData = try! Data(contentsOf: fileUrl)
        //将图片转为base64编码
        let base64 = fileData.base64EncodedString(options: .endLineWithLineFeed)
        //继续将base64字符串urlencode一下，确保只有数字和字母
        let imageString = base64.addingPercentEncoding(withAllowedCharacters:
            .alphanumerics)
        
        //请求接口
        request(imageString: imageString!)
    }
    
    //请求API接口
    func  request(imageString: String) {
//        Network.request(Httpbin.ocrParams(imageString), success: { (json) in
//
//            if json != JSON.null{
//
//                print(json)
////                DispatchQueue.main.async {
////                }
//            }
//        }, error: { (statusCode) in
//            //服务器报错等问题
//            print("请求错误！错误码：\(statusCode)")
//        }) { (error) in
//              //没有网络等问题
//             print("请求失败！错误信息：\(error.errorDescription ?? "")")
//        }
    }
    
    
    //解析数据并显示结果
    func showResult(data:Data) {
        var result = ""
        let json = try! JSON(data: data)
        //循环每个区域识别出来的内容
        for (_,subJson):(String, JSON) in json["retData"]{
            result.append("-- 区域（")
            result.append("左|\(subJson["rect"]["left"].intValue) ")
            result.append("上|\(subJson["rect"]["top"].intValue) ")
            result.append("宽度|\(subJson["rect"]["width"].intValue) ")
            result.append("高度|\(subJson["rect"]["height"].intValue)）--\n")
            result.append("\(subJson["word"].stringValue)\n\n") //识别的内容
        }
        //在主线程中显示解析的结果
        DispatchQueue.main.async{
            self.textView.text = result
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
