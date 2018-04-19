//
//  Constant.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

/// 当前app信息
let GetAppInfo = Bundle.main.infoDictionary
/// 当前app版本号
let GetAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
/// 获取设备系统号
let GetSystemVersion = UIDevice.current.systemVersion

/// 全屏宽度
let kScreenWitdh = UIScreen.main.bounds.width
/// 全屏高度，不含状态栏高度
let kScreenHeight = UIScreen.main.bounds.height
/// 全屏高度，含状态栏高度
let kAllHeight = (UIScreen.main.applicationFrame.size.height + 20.0)
/// 视图控制器高度，不含导航栏控制器高度
let kBodyHeight = (UIScreen.main.applicationFrame.size.height - 44.0)

/// tabbar切换视图控制器高度
let kTabbarHeight = 49.0
/// 搜索视图高度
let kSearchBarHeight = 45.0
/// 状态栏高度
let kStatusBarHeight    = 20.0
/// 导航栏高度
let kNavigationHeight   = 44.0


// MARK: - 时间格式

enum TimeFormat:String
{
    case format_default            = "yyyy-MM-dd HH:mm:ss"
    case format_yyMdHm             = "yy-MM-dd HH:mm"
    case format_yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case format_yMd                = "yyyy-MM-dd"
    case format_MdHms              = "MM-dd HH:mm:ss"
    case format_MdHm               = "MM-dd HH:mm"
    case format_Hms                = "HH:mm:ss"
    case format_Hm                 = "HH:mm"
    case format_Md                 = "MM-dd"
    case format_yyMd               = "yy-MM-dd"
    case format_YYMMdd             = "yyyyMMdd"
    case format_yyyyMdHms          = "yyyyMMddHHmmss"
    case format_yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case format_yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case format_yMdWithSlash       = "yyyy/MM/dd"
    case format_yM                 = "yyyy-MM"
    case format_yMdChangeSeparator = "yyyy.MM.dd"
}

class Constant: NSObject {

}
