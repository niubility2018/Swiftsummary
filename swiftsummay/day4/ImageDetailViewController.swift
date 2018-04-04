//
//  ImageDetailViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/4.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import AssetsLibrary
class ImageDetailViewController: UIViewController {

    //选中的图片资源
    var myAsset:ALAsset!
    //用于显示图片信息
    var textView: UITextView!
    //用于显示原图
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取文件名
        let representation =  myAsset.defaultRepresentation()
        self.title = representation?.filename()
        
        imageView = UIImageView(frame: CGRect(x: 20, y: 64, width: 200, height: 50))
        imageView.backgroundColor = .orange
        self.view.addSubview(imageView)
        
        textView = UITextView(frame: CGRect(x: 20, y: 120, width: 300, height: 300))
        textView.backgroundColor = .red
        self.view.addSubview(textView)
        
        //获取图片信息
        textView.text = "日期：\(myAsset.value(forProperty: ALAssetPropertyDate))\n"
            + "类型：\(myAsset.value(forProperty: ALAssetPropertyType))\n"
            + "位置：\(myAsset.value(forProperty: ALAssetPropertyLocation))\n"
            + "时长：\(myAsset.value(forProperty: ALAssetPropertyDuration))\n"
            + "方向：\(myAsset.value(forProperty: ALAssetPropertyOrientation))"
        
        //获取原图
//        let imageBuffer = UnsafeMutablePointer<UInt8>(Int(representation?.size()))
        
        let imageBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int((representation?.size())!))
        
//        let bufferSize = representation?.getBytes(imageBuffer, fromOffset: Int64(0),
//                                                  length: Int((representation?.size())), error: nil)
        let bufferSize = representation?.getBytes(imageBuffer,
                                                  fromOffset: Int64(0),
                                                  length: Int((representation?.size())!),
                                                  error: nil)
        
        
        let data =  NSData(bytesNoCopy:imageBuffer ,length:bufferSize!, freeWhenDone:true)
        
        
        imageView.image = UIImage(data: data as Data)
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
