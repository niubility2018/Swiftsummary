//
//  String+util.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/20.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit


extension String {
    //返回字数
    var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}

class String_util: NSObject {

}
