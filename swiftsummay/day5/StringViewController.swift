//
//  StringViewController.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/10.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

extension String{
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

class StringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let str1 = "欢迎访问hangge.com"
        let str2 = str1.subString(start: 4, length: 6)
        print("原字符串：",str1)
        print("截取的字符串：",str2)
        
        let urlStr = "http://hanggge.com?name=航歌&key=!*'();:@&=+$,/?%#[]"
        print("转义后的url：\(urlStr.urlEncoded())")
        print("还原后的url：\(urlStr.urlEncoded().urlDecoded())")
        
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
